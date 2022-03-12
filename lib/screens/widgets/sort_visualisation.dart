import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/model/algorithm_step.dart';
import 'package:pysort_flutter/model/data_set.dart';
import 'package:pysort_flutter/providers/result_state.dart';
import 'package:pysort_flutter/providers/sort_graph_state.dart';

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

        final res = results.sortResults.entries.first.value;
        return SortGraphState(steps: res.steps, data: res.inputData);
      },
      builder: (ctx, _) {
        return Consumer<SortGraphState?>(builder: (ctx, state, _) {
          if (state == null) {
            return const Center(
              child: Text("Nothing"),
            );
          }
          return Row(
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
                      if (state.currentStep.firstIndex == index) {
                        status = BarStatus.selected;
                      } else if (state.currentStep.secondIndex == index) {
                        status =
                            true ? BarStatus.willBeMoved : BarStatus.selected;
                      } else {
                        status = BarStatus.none;
                      }
                      return Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Bar(
                            height: element / state.data.highestValue,
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
