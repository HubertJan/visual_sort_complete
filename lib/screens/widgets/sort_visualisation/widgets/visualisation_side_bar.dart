import 'package:dropdown_button2/dropdown_button2.dart';
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
        padding: EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                Text("Datensatz"),
                SizedBox(
                  height: 8,
                ),
                DropdownButton2<String>(
                  isExpanded: true,
                  itemHeight: 32,
                  dropdownDecoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(8)),
                    color: HSLColor.fromColor(
                            Theme.of(context).colorScheme.primary)
                        .withLightness(0.3)
                        .toColor(),
                  ),
                  buttonPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  iconEnabledColor: Theme.of(context).colorScheme.onBackground,
                  underline: const SizedBox(),
                  buttonHeight: 32,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                      ),
                  value: "100",
                  items: const [
                    DropdownMenuItem(
                      child: Text("mit 100 Elementen"),
                      value: "100",
                    ),
                    DropdownMenuItem(
                      child: Text("mit 200 Elementen"),
                      value: "200",
                    )
                  ],
                  onChanged: (newId) {
                    /*   _currentDataSet =
                    state.dataSets.firstWhere((element) => element.id == newId);
                setState(() {}); */
                  },
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      );
    });
  }
}
