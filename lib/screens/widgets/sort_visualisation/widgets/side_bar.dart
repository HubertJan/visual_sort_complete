import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/sort_graph_state.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SortGraphState?>(builder: (ctx, state, _) {
      if (state == null) {
        return const SizedBox();
      }
      return Container(
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
                  const SizedBox(
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
                IconButton(
                  icon: const Icon(
                    Icons.skip_previous,
                  ),
                  iconSize: 32,
                  color: Theme.of(context).colorScheme.onSurface,
                  disabledColor:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
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
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.3);
                                  }
                                  return Theme.of(context)
                                      .colorScheme
                                      .onSurface;
                                },
                              ),
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
                                      delay: const Duration(milliseconds: 1),
                                    );
                                  }
                                : null,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.3);
                                  }
                                  return Theme.of(context)
                                      .colorScheme
                                      .onSurface;
                                },
                              ),
                            ),
                            child: Row(
                              children: [
                                const Text("Auto"),
                                Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(pi),
                                  child: const Icon(Icons.play_circle),
                                ),
                              ],
                            ),
                            onPressed: state.canPrevious
                                ? () {
                                    state.startAutoPlay(
                                      delay: const Duration(milliseconds: 1),
                                      isForwards: false,
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
                  disabledColor:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
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
      );
    });
  }
}
