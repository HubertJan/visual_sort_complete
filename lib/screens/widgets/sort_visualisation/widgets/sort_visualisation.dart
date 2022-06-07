import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                itemBuilder: (ctx, index) {
                  final element = state.elementList[index];
                  final status =
                      state.currentStep?.getBarStatusOf(index)?.toBarStatus() ??
                          BarStatus.none;

                  return Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Bar(
                        height: element / (state.data.highestValue * 1.05),
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
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 64,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                              "${(state.currentStepIndex / state.steps.length * 100).toStringAsFixed(2)}%"),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Container(
                          height: 16,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            heightFactor: 1,
                            widthFactor:
                                state.currentStepIndex / state.steps.length,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*               SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 64,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${state.steps.length}",
                          ),
                        ),
                      ), */
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: IconButton(
                        icon: const Icon(
                          Icons.skip_previous,
                        ),
                        iconSize: 32,
                        color: Theme.of(context).colorScheme.onSurface,
                        disabledColor: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.3),
                        onPressed: state.canPrevious
                            ? () {
                                state.previousStep();
                              }
                            : null,
                      ),
                    ),
                    !state.isAutoPlay
                        ? Column(
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.onSurface),
                                ),
                                child: Row(
                                  children: const [
                                    Text("Auto"),
                                    Icon(Icons.play_circle),
                                  ],
                                ),
                                onPressed: state.canPrevious
                                    ? () {
                                        state.startAutoPlay(
                                            delay:
                                                const Duration(milliseconds: 1),
                                            isForwards: false);
                                      }
                                    : null,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.onSurface),
                                ),
                                child: Row(
                                  children: const [
                                    Text("Auto"),
                                    Icon(Icons.play_circle),
                                  ],
                                ),
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
                        : IconButton(
                            icon: const Icon(
                              Icons.stop,
                            ),
                            iconSize: 32,
                            color: Theme.of(context).colorScheme.onSurface,
                            disabledColor: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.3),
                            onPressed: () {
                              state.stopAutoPlay();
                            },
                          ),
                    IconButton(
                      icon: const Icon(
                        Icons.skip_next,
                      ),
                      iconSize: 32,
                      color: Theme.of(context).colorScheme.onSurface,
                      disabledColor: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.3),
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

extension _BarStatusConverter on int {
  BarStatus toBarStatus() {
    switch (this) {
      case 11:
        return BarStatus.selected;
      case 10:
        return BarStatus.willBeMoved;
      default:
        return BarStatus.none;
    }
  }
}

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
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection = TextDirection.ltr,
    this.verticalDirection = VerticalDirection.down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      verticalDirection: verticalDirection,
      textDirection: textDirection,
      children: List.generate(itemCount, (index) => itemBuilder(context, index))
          .toList(),
    );
  }
}
