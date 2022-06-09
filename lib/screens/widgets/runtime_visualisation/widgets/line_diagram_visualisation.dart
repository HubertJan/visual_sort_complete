import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/model/algorithm_examination_result.dart';
import 'package:pysort_flutter/model/data_set.dart';
import 'package:pysort_flutter/providers/result_state.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pysort_flutter/screens/widgets/runtime_visualisation/widgets/text_symbol_render.dart';
import 'package:charts_common/common.dart' as common;

import '../graph_colors.dart';

class LineDiagramVisualisation extends StatelessWidget {
  LineDiagramVisualisation({Key? key}) : super(key: key);

  Map<String, List<RuntimeData>> convertDataToRuntimeDataPerAlgorithm(
    Map<String, AlgorithmExaminationResult> dataSetIdToResult,
    List<DataSet> dataSets,
  ) {
    final Map<String, List<RuntimeData>> algorithmToRuntimes = {};
    for (final resultEntry in dataSetIdToResult.entries) {
      final data = <RuntimeData>[];
      for (final runtimeEntry in resultEntry.value.runtimePerDataSet.entries) {
        final dataSet =
            dataSets.firstWhere((element) => element.id == runtimeEntry.key);
        data.add(
          RuntimeData(
            itemCount: dataSet.data.length,
            runtime: runtimeEntry.value.inMicroseconds / 1000,
          ),
        );
      }
      algorithmToRuntimes[resultEntry.key] = data;
    }
    return algorithmToRuntimes;
  }

  List<charts.Series<RuntimeData, int>> createChartData(
      Map<String, AlgorithmExaminationResult> dataSetIdToResult,
      List<DataSet> dataSets) {
    final dataSet =
        convertDataToRuntimeDataPerAlgorithm(dataSetIdToResult, dataSets);
    final dataSerie = <charts.Series<RuntimeData, int>>[];

    for (final data in dataSet.entries) {
      final index = dataSerie.length;
      dataSerie.add(charts.Series<RuntimeData, int>(
        id: data.key,
        colorFn: (_, __) =>
            charts.Color.fromHex(code: graphColors[index].toHexTriplet()),
        domainFn: (runtimePerLength, _) => runtimePerLength.itemCount,
        measureFn: (runtimePerLength, _) => runtimePerLength.runtime,
        data: data.value,
      ));
    }
    return dataSerie;
  }

  List<RuntimeData> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultsState>(builder: (context, state, _) {
      return Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: charts.LineChart(
          createChartData(state.sortResults, state.dataSets),
          domainAxis: charts.AxisSpec<num>(
            tickProviderSpec: charts.BasicNumericTickProviderSpec(
              zeroBound: false,
              desiredTickCount: state.dataSets.length,
            ),
          ),
          defaultInteractions: false,
          selectionModels: [
            charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: (charts.SelectionModel model) {
                selectedValues = model.selectedDatum
                    .map((e) => e.datum as RuntimeData)
                    .toList();
              },
            ),
          ],
          behaviors: [
            charts.SelectNearest(
              selectionMode: common.SelectionMode.single,
            ),
            charts.SeriesLegend(position: charts.BehaviorPosition.end),
            charts.LinePointHighlighter(
              symbolRenderer: TextSymbolRenderer(
                () {
                  return "${selectedValues.first.runtime.toStringAsFixed(3)} ms";
                },
              ),
            )
          ],
          primaryMeasureAxis: const charts.NumericAxisSpec(
            showAxisLine: false,
            tickProviderSpec: charts.BasicNumericTickProviderSpec(
              zeroBound: true,
            ),
          ),
        ),
      );
    });
  }
}

class RuntimeData {
  final double runtime;
  final int itemCount;
  RuntimeData({
    required this.runtime,
    required this.itemCount,
  });
}
