import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/sort_config_state.dart';

import 'data_input_field.dart';
import 'side_bar_title_bar.dart';

class DatasetSetup extends StatefulWidget {
  const DatasetSetup({
    Key? key,
  }) : super(key: key);

  @override
  State<DatasetSetup> createState() => _DatasetSetupState();
}

class _DatasetSetupState extends State<DatasetSetup> {
  int minValue = 0;
  int maxValue = 100;
  int minAmountOfElements = 100;
  int maxAmountOfElements = 1000;

  bool onlyUniqueNumbers = false;

  bool get _canGenerateDataSet {
    return maxValue != 0 &&
        minValue != maxValue &&
        minAmountOfElements != 0 &&
        (!onlyUniqueNumbers || maxAmountOfElements < maxValue + 1 - minValue);
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
                      Text(" $minAmountOfElements bis $maxAmountOfElements"),
                      RangeSlider(
                        min: 100,
                        max: 1000,
                        divisions: 9,
                        onChanged: (v) {
                          minAmountOfElements = v.start.ceil();
                          maxAmountOfElements = v.end.ceil();
                          setState(() {});
                        },
                        values: RangeValues(minAmountOfElements.toDouble(),
                            maxAmountOfElements.toDouble()),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("Niedrigste Zahl: $minValue"),
                      Slider(
                        max: maxValue.toDouble(),
                        divisions: 1000,
                        label: minValue.toString(),
                        onChanged: (v) {
                          minValue = (v).toInt();
                          setState(() {});
                        },
                        value: minValue.toDouble(),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("Höchste Zahl: $maxValue"),
                      Slider(
                        max: 1000,
                        divisions: 100,
                        label: maxValue.toString(),
                        onChanged: (v) {
                          maxValue = (v).toInt();
                          if (minValue > maxValue) {
                            minValue = maxValue;
                          }
                          setState(() {});
                        },
                        value: maxValue.toDouble(),
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
                                    initialAmount: minAmountOfElements,
                                    maxAmount: maxAmountOfElements,
                                    amountIncreasePerDataSet: 100,
                                    lowestValue: minValue,
                                    highestValue: maxValue,
                                    onlyUniqueNumbers: onlyUniqueNumbers,
                                  );
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
