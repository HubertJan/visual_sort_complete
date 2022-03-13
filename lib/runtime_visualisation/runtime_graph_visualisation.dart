import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/model/sort_result.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../providers/result_state.dart';

class RuntimeGraphVisualisation extends StatelessWidget {
  const RuntimeGraphVisualisation({Key? key}) : super(key: key);

  static List<ChartSeries<RuntimePerLength, int>> createData(
      Map<String, SortResult> results) {
    final Map<String, List<RuntimePerLength>> algorithmToRuntimes = {};
    for (final resultEntry in results.entries) {
      final data = <RuntimePerLength>[];
      for (final runtimeEntry in resultEntry.value.runtimes.entries) {
        data.add(RuntimePerLength(
            runtimeEntry.key, runtimeEntry.value.inMilliseconds));
      }
      algorithmToRuntimes[resultEntry.key] = data;
    }

    final List<ChartSeries<RuntimePerLength, int>> seriesList = [];
    for (final data in algorithmToRuntimes.entries) {
      seriesList.add(LineSeries<RuntimePerLength, int>(
          name: data.key,
          xValueMapper: (RuntimePerLength data, _) => data.runtime,
          yValueMapper: (RuntimePerLength data, _) => data.length,
          dataSource: data.value,
          markerSettings: MarkerSettings(
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
            majorGridLines: MajorGridLines(
              width: 0,
            ),
            isVisible: false,
            numberFormat: NumberFormat.compactCurrency(
                symbol: "Elemente", locale: "eu", decimalDigits: 0),
            labelStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compactCurrency(
                symbol: "ms", locale: "eu", decimalDigits: 0),
            majorGridLines: MajorGridLines(
              width: 0,
            ),
            isVisible: true,
          ),
          plotAreaBorderWidth: 0,
          palette: [Colors.blue, Colors.yellow, Colors.red, Colors.green],
          borderWidth: 0,
          tooltipBehavior: TooltipBehavior(enable: true),
          series: createData(state.sortResults),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
      );
    });
  }
}

class RuntimePerLength {
  final int runtime;
  final int length;
  RuntimePerLength(this.runtime, this.length);
}
