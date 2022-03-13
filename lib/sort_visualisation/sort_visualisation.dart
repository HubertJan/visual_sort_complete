import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/result_state.dart';
import 'package:pysort_flutter/providers/sort_graph_state.dart';

class SortVisualisation extends StatelessWidget {
  const SortVisualisation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              color: Theme.of(context).colorScheme.surface,
              child: RowBuilder(
                itemBuilder: (ctx, index) {
                  final element = state.elementList[index];
                  final BarStatus status;
                  final statusCode = state.currentStep?.getBarStatusOf(index);
                  switch (statusCode) {
                    case 20:
                    case 21:
                    case 11:
                      status = BarStatus.selected;
                      break;
                    case 10:
                      status = BarStatus.willBeMoved;
                      break;
                    default:
                      status = BarStatus.none;
                      break;
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
                itemCount: state.elementList.length,
              ),
            ),
          ),
          Container(
            width: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 8,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${state.currentStepIndex}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text("Zurück"),
                      onPressed: state.canPrevious
                          ? () {
                              state.previousStep();
                            }
                          : null,
                    ),
                    !state.isAutoPlay
                        ? Column(
                            children: [
                              TextButton(
                                child: Text("Automatisch rückwärts"),
                                onPressed: state.canPrevious
                                    ? () {
                                        state.startAutoPlay(
                                            delay:
                                                const Duration(milliseconds: 1),
                                            isForwards: false);
                                      }
                                    : null,
                              ),
                              TextButton(
                                child: Text("Automatisch vorwärts"),
                                onPressed: state.canNext
                                    ? () {
                                        state.startAutoPlay(
                                          delay:
                                              const Duration(milliseconds: 1),
                                        );
                                      }
                                    : null,
                              ),
                            ],
                          )
                        : TextButton(
                            child: Text("Stoppen"),
                            onPressed: () {
                              state.stopAutoPlay();
                            },
                          ),
                    TextButton(
                      child: Text("Nächster"),
                      onPressed: state.canNext
                          ? () {
                              state.nextStep();
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
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
