import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/sort_config_state.dart';
import 'package:pysort_flutter/side_bar/widgets/data_input_field.dart';

import 'side_bar_title_bar.dart';

class DatasetSetup extends StatefulWidget {
  const DatasetSetup({
    Key? key,
  }) : super(key: key);

  @override
  State<DatasetSetup> createState() => _DatasetSetupState();
}

class _DatasetSetupState extends State<DatasetSetup> {
  int minNumber = 0;
  int maxNumber = 100;
  int minNumberOfElements = 100;
  int maxNumberOfElements = 1000;

  bool onlyUniqueNumbers = false;

  bool get _canGenerateDataSet {
    return maxNumber != 0 &&
        minNumber != maxNumber &&
        minNumberOfElements != 0 &&
        (!onlyUniqueNumbers || maxNumberOfElements < maxNumber + 1 - minNumber);
  }

  @override
  Widget build(BuildContext context) {
    String text = "[";
    for (final dataSet
        in Provider.of<SortConfig>(context, listen: true).dataSet) {
      text = "$text[${dataSet.asString()}],";
    }
    text = "$text]";
    return Column(
      children: [
        const SideBarTitleBar(
          title: "Eingabedaten",
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: DateInputField(text: text),
            ),
            Expanded(
              child: SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Anzahl an Elementen:",
                        textAlign: TextAlign.start,
                      ),
                      Text(" $minNumberOfElements bis $maxNumberOfElements"),
                      RangeSlider(
                        min: 100,
                        max: 1000,
                        divisions: 9,
                        onChanged: (v) {
                          minNumberOfElements = v.start.ceil();
                          maxNumberOfElements = v.end.ceil();
                          setState(() {});
                        },
                        values: RangeValues(minNumberOfElements.toDouble(),
                            maxNumberOfElements.toDouble()),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("Niedrigste Zahl: $minNumber"),
                      Slider(
                        max: maxNumber.toDouble(),
                        divisions: 1000,
                        label: minNumber.toString(),
                        onChanged: (v) {
                          minNumber = (v).toInt();
                          setState(() {});
                        },
                        value: minNumber.toDouble(),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("Höchste Zahl: $maxNumber"),
                      Slider(
                        max: 1000,
                        divisions: 100,
                        label: maxNumber.toString(),
                        onChanged: (v) {
                          maxNumber = (v).toInt();
                          if (minNumber > maxNumber) {
                            minNumber = maxNumber;
                          }
                          setState(() {});
                        },
                        value: maxNumber.toDouble(),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Keine Zahlen doppelt"),
                          Checkbox(
                            value: onlyUniqueNumbers,
                            fillColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.primary),
                            onChanged: (value) {
                              onlyUniqueNumbers = value ?? false;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: TextButton(
                          child: const Text("Datensatz generieren"),
                          onPressed: _canGenerateDataSet
                              ? () async {
                                  await Provider.of<SortConfig>(context,
                                          listen: false)
                                      .generateDataSet(
                                          minNumber,
                                          maxNumber,
                                          minNumberOfElements,
                                          maxNumberOfElements,
                                          100,
                                          onlyUniqueNumbers);
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
