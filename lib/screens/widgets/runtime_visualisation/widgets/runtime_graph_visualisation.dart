import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/model/algorithm_examination_result.dart';
import 'package:pysort_flutter/model/data_set.dart';
import 'package:pysort_flutter/providers/result_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class RuntimeGraphVisualisation extends StatelessWidget {
  const RuntimeGraphVisualisation({Key? key}) : super(key: key);

  static List<ChartSeries<RuntimePerLength, double>> createData(
      Map<String, AlgorithmExaminationResult> results, List<DataSet> dataSets) {
    final Map<String, List<RuntimePerLength>> algorithmToRuntimes = {};
    for (final resultEntry in results.entries) {
      final data = <RuntimePerLength>[];
      for (final runtimeEntry in resultEntry.value.runtimePerDataSet.entries) {
        final dataSet =
            dataSets.firstWhere((element) => element.id == runtimeEntry.key);
        data.add(RuntimePerLength(
          length: dataSet.data.length,
          runtime: runtimeEntry.value.inMicroseconds / 1000,
        ));
      }
      algorithmToRuntimes[resultEntry.key] = data;
    }

    final List<ChartSeries<RuntimePerLength, double>> seriesList = [];
    for (final data in algorithmToRuntimes.entries) {
      seriesList.add(LineSeries<RuntimePerLength, double>(
          name: data.key,
          xValueMapper: (RuntimePerLength data, _) => data.length.toDouble(),
          yValueMapper: (RuntimePerLength data, _) => data.runtime,
          dataSource: data.value,
          markerSettings: const MarkerSettings(
            isVisible: true,
          )));
    }
    return seriesList;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultsState>(builder: (context, state, _) {
      return Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: SfCartesianChart(
          legend: Legend(
            isVisible: true,
            textStyle: Theme.of(context).textTheme.bodyLarge,
          ),
          primaryXAxis: NumericAxis(
            majorGridLines: const MajorGridLines(
              width: 0,
            ),
            isVisible: false,
            numberFormat: NumberFormat.compactCurrency(
                symbol: "Elemente", locale: "eu", decimalDigits: 0),
            labelStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compactCurrency(
                symbol: "ms", locale: "eu", decimalDigits: 2),
            majorGridLines: const MajorGridLines(
              width: 0,
            ),
            isVisible: true,
          ),
          plotAreaBorderWidth: 0,
          palette: const [Colors.blue, Colors.yellow, Colors.red, Colors.green],
          borderWidth: 0,
          tooltipBehavior: TooltipBehavior(enable: true),
          series: createData(state.sortResults, state.dataSets),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
      );
    });
  }
}

class RuntimePerLength {
  final double runtime;
  final int length;
  RuntimePerLength({required this.runtime, required this.length});
}
