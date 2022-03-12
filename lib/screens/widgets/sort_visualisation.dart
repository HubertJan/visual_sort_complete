import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/model/algorithm_step.dart';
import 'package:pysort_flutter/model/data_set.dart';
import 'package:pysort_flutter/providers/result_state.dart';
import 'package:pysort_flutter/providers/sort_graph_state.dart';

import '../../providers/sort_config_state.dart';

class SortVisualisation extends StatefulWidget {
  const SortVisualisation({Key? key}) : super(key: key);

  @override
  State<SortVisualisation> createState() => _SortVisualisationState();
}

class _SortVisualisationState extends State<SortVisualisation> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<ResultsState, SortGraphState?>(
      create: (ctx) {
        return null;
      },
      update: (BuildContext ctx, ResultsState results,
          SortGraphState? previousAlgorithmState) {
        if (!results.hasResults) {
          return null;
        }
        final random = Random();

        return SortGraphState(
            steps: [
              AlgorithmStep(from: 0, to: 2, doesMove: true),
              AlgorithmStep(from: 1, to: 3, doesMove: true),
              AlgorithmStep(from: 2, to: 1, doesMove: false),
              AlgorithmStep(from: 4, to: 3, doesMove: true),
              AlgorithmStep(from: 5, to: 2, doesMove: false)
            ],
            data: DataSet(
                List<int>.generate(1000, (index) => random.nextInt(50))));
      },
      builder: (ctx, _) {
        return Consumer<SortGraphState?>(builder: (ctx, state, _) {
          if (state == null) {
            return Expanded(
              child: Center(
                child: Text("Nothing"),
              ),
            );
          }
          return Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.99),
                    child: RowBuilder(
                      itemBuilder: (ctx, index) {
                        final element = state.currentList[index];
                        final BarStatus status;
                        if (state.currentStep.from == index) {
                          status = BarStatus.selected;
                        } else if (state.currentStep.to == index) {
                          status = state.currentStep.doesMove
                              ? BarStatus.willBeMoved
                              : BarStatus.selected;
                        } else {
                          status = BarStatus.none;
                        }
                        return Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Bar(
                              height: element / 50,
                              status: status,
                            ),
                          ),
                        );
                      },
                      itemCount: state.currentList.length,
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${state.currentStepIndex}"),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: Text("Zurück"),
                            onPressed: () {
                              state.previousStep();
                            },
                          ),
                          TextButton(
                            child: Text("Nächster"),
                            onPressed: () {
                              state.nextStep();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

enum BarStatus { none, selected, willBeMoved }

class Bar extends StatelessWidget {
  final double height;
  final BarStatus status;

  const Bar({Key? key, required this.height, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color;
    switch (status) {
      case BarStatus.none:
        color = Colors.blue;
        break;
      case BarStatus.selected:
        color = Colors.yellow;
        break;
      case BarStatus.willBeMoved:
        color = Colors.pink;
        break;
    }
    return FractionallySizedBox(
      heightFactor: height,
      child: Container(
        width: 100,
        color: color,
      ),
    );
  }
}

class RowBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final int itemCount;

  const RowBuilder({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.mainAxisSize: MainAxisSize.max,
    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.textDirection = TextDirection.ltr,
    this.verticalDirection: VerticalDirection.down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(itemCount, (index) => itemBuilder(context, index))
          .toList(),
    );
  }
}
