import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/result_state.dart';

class RuntimeVisualisation extends StatelessWidget {
  const RuntimeVisualisation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultsState>(builder: (context, state, _) {
      final dataSetLength = state.dataSets[0].data.length;
      final longestRuntime =
          state.longestRuntimeOf(state.dataSets[0].data.length);
      final maxRuntime = longestRuntime.inMicroseconds != 0
          ? (longestRuntime.inMicroseconds * 1.3)
          : 1;

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
                    return RuntimeBar(
                      name: result.key,
                      miliseconds:
                          result.value.runtimes[dataSetLength]!.inMicroseconds /
                              1000,
                      height:
                          result.value.runtimes[dataSetLength]!.inMicroseconds /
                              maxRuntime,
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
  final double height;
  final String name;
  final double miliseconds;

  const RuntimeBar(
      {Key? key,
      required this.height,
      required this.name,
      required this.miliseconds})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              widthFactor: height,
              child: Container(
                height: 50,
                color: Colors.yellow,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    "$miliseconds ms",
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
