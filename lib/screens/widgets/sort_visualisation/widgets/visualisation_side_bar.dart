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
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            if (state.dataSets.length != 1)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 8,
                  ),
                  SelectDataSetDropdownMenu(),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("Geschwindigkeit",
                          textAlign: TextAlign.start)),
                  Slider(
                    min: 0,
                    max: 60,
                    divisions: 30,
                    label: () {
                      final timeInSeconds =
                          state.durationPerStep.inMilliseconds;
                      if (timeInSeconds < 20) {
                        return "Schnell";
                      } else if (timeInSeconds < 40) {
                        return "Normal";
                      } else {
                        return "Langsam";
                      }
                    }(),
                    value:
                        (60 - state.durationPerStep.inMilliseconds).toDouble(),
                    onChanged: (timeInMilliseconds) {
                      state.durationPerStep = Duration(
                          milliseconds: 60 - timeInMilliseconds.toInt());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class SelectDataSetDropdownMenu extends StatelessWidget {
  const SelectDataSetDropdownMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Datensatz"),
        const SizedBox(
          height: 8,
        ),
        Consumer<SortGraphState?>(builder: (ctx, state, _) {
          if (state == null) {
            return const SizedBox();
          }
          return DropdownButton2<String>(
            isExpanded: true,
            itemHeight: 32,
            dropdownDecoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(8)),
              color: HSLColor.fromColor(Theme.of(context).colorScheme.primary)
                  .withLightness(0.3)
                  .toColor(),
            ),
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            buttonDecoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            iconEnabledColor: Theme.of(context).colorScheme.onBackground,
            underline: const SizedBox(),
            buttonHeight: 32,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                ),
            value: state.currentDataSetId,
            items: state.dataSets
                .map((set) => DropdownMenuItem(
                      child: Text("mit ${set.data.length} Elementen"),
                      value: set.id,
                    ))
                .toList(),
            onChanged: (newId) {
              state.switchDataSet(newId!);
            },
          );
        }),
      ],
    );
  }
}
