import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/result_state.dart';

class BarGraphVisualisation extends StatelessWidget {
  const BarGraphVisualisation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultsState>(builder: (context, state, _) {
      final dataSetLength = state.dataSets[0].data.length;
      final dataSetId = state.dataSets[0].id;
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
              child: Text(
                "Laufzeit bei $dataSetLength Elementen",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white),
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
                        final runtime =
                            result.value.runtimePerDataSet[dataSetId]!;
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
