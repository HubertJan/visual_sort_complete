import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/sort_graph_state.dart';
import 'package:pysort_flutter/widgets/progress_bar.dart';

import 'visualisation_control_buttons.dart';

class VisualisationSideBar extends StatelessWidget {
  const VisualisationSideBar({
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
            ProgresssBar(
              currentValue: state.currentStepIndex,
              maxValue: state.steps.length,
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 64,
              child: VisualisationControlButtons(),
            ),
          ],
        ),
      );
    });
  }
}
