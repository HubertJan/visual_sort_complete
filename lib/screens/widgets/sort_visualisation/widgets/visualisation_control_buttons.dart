import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/sort_graph_state.dart';

/// TODO: Extract into reusable ControlButtonsWidget
class VisualisationControlButtons extends StatelessWidget {
  const VisualisationControlButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SortGraphState?>(builder: (ctx, state, _) {
      if (state == null) {
        return const SizedBox();
      }
      return Row(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.resolveWith(
                          (states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.3);
                            }
                            return Theme.of(context).colorScheme.onSurface;
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
                        foregroundColor: MaterialStateProperty.resolveWith(
                          (states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.3);
                            }
                            return Theme.of(context).colorScheme.onSurface;
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
                  disabledColor:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
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
      );
    });
  }
}
