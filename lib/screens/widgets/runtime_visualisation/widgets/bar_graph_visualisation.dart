import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/model/data_set.dart';
import 'package:pysort_flutter/providers/result_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarGraphVisualisation extends StatefulWidget {
  const BarGraphVisualisation({Key? key}) : super(key: key);

  @override
  State<BarGraphVisualisation> createState() => _BarGraphVisualisationState();
}

class _BarGraphVisualisationState extends State<BarGraphVisualisation> {
  DataSet? _currentDataSet;

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultsState>(builder: (context, state, _) {
      if (_currentDataSet != null &&
          !state.dataSets.any((element) => element.id == _currentDataSet?.id)) {
        _currentDataSet = null;
      }
      _currentDataSet ??= state.dataSets[0];
      final dataSet = state.dataSets
          .firstWhere((element) => element.id == _currentDataSet!.id);
      final dataSetLength = dataSet.data.length;
      final longestRuntime =
          state.calculateLongestRuntime(dataSetLength: dataSetLength);
      final maxRuntime = longestRuntime.inMicroseconds != 0
          ? longestRuntime
          : const Duration(milliseconds: 1);

      return Container(
        padding: const EdgeInsets.all(32),
        color: Theme.of(context)
            .colorScheme
            .surface, //Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                /*             mainAxisAlignment: MainAxisAlignment.center, */
                children: [
                  Text(
                    "Laufzeit bei ",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        itemHeight: 64,
                        alignment: Alignment.topLeft,
                        /*      iconSize: 0, */
                        iconEnabledColor:
                            Theme.of(context).colorScheme.onBackground,
                        underline: const SizedBox(),
                        dropdownColor: Theme.of(context).colorScheme.background,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.white,
                            ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        value: _currentDataSet!.id,
                        items: state.dataSets
                            .map(
                              (set) => DropdownMenuItem(
                                child: Text("${set.data.length}"),
                                value: set.id,
                              ),
                            )
                            .toList(),
                        onChanged: (newId) {
                          _currentDataSet = state.dataSets
                              .firstWhere((element) => element.id == newId);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Text(
                    " Elementen",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.sortResults.length,
                  itemBuilder: (context, i) {
                    final result = state.sortResults.entries.toList()[i];
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final runtime = result
                            .value.runtimePerDataSet[_currentDataSet!.id]!;
                        return RuntimeBar(
                          name: result.key,
                          runtime: runtime,
                          maxRuntime: maxRuntime,
                          hasTextInBar: constraints.maxWidth < 800,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class RuntimeBar extends StatelessWidget {
  final Duration maxRuntime;
  final String name;
  final Duration runtime;
  final bool hasTextInBar;

  const RuntimeBar(
      {Key? key,
      required this.maxRuntime,
      required this.name,
      required this.runtime,
      this.hasTextInBar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final runtimeInMilliseconds = runtime.inMicroseconds / 1000;
    final width = runtime.inMicroseconds / maxRuntime.inMicroseconds;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: width,
              child: Container(
                height: 50,
                color: Colors.yellow,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: hasTextInBar
                    ? Row(
                        children: [
                          Text(name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary)),
                          Text("$runtimeInMilliseconds ms",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary)),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )
                    : null,
              ),
            ),
          ),
          if (!hasTextInBar)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      "$runtimeInMilliseconds ms",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Text(name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
