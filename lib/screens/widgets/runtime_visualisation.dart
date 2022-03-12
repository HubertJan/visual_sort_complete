import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/result_state.dart';

class RuntimeVisualisation extends StatelessWidget {
  const RuntimeVisualisation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultsState>(builder: (context, state, _) {
      final maxRuntime = state.longestRuntime.inMicroseconds != 0
          ? (state.longestRuntime.inMicroseconds * 1.3).toInt()
          : 1;

      return Container(
        color: Theme.of(context)
            .colorScheme
            .background
            .withOpacity(0.99), //Theme.of(context).colorScheme.background,
        child: Center(
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RuntimeBar(
                    name: state.sortResults.entries.first.key,
                    ms: state
                        .sortResults.entries.first.value.runtime.inMicroseconds,
                    height: state.sortResults.entries.first.value.runtime
                            .inMicroseconds /
                        maxRuntime,
                  ),
                  RuntimeBar(
                    name: "Text",
                    height: 0.5,
                    ms: maxRuntime ~/ 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class RuntimeBar extends StatelessWidget {
  final double height;
  final String name;
  final int ms;

  const RuntimeBar(
      {Key? key, required this.height, required this.name, required this.ms})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Flexible(
            flex: 5,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: height,
              child: Container(
                height: 50,
                color: Colors.yellow,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "$ms ms",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(name, style: Theme.of(context).textTheme.headline5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
