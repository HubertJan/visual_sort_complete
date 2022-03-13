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
  int numberOfElements = 1000;
  bool onlyUniqueNumbers = false;

  bool get _canGenerateDataSet {
    return maxNumber != 0 &&
        minNumber != maxNumber &&
        numberOfElements != 0 &&
        (!onlyUniqueNumbers || numberOfElements < maxNumber + 1 - minNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SideBarTitleBar(
          title: "Eingabedaten",
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 400,
                child: DateInputField(
                    text: Provider.of<SortConfig>(context, listen: true)
                            .dataSet
                            ?.asString() ??
                        ""),
              ),
            ),
            Expanded(
              child: Container(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Anzahl an Elementen: $numberOfElements",
                        textAlign: TextAlign.start,
                      ),
                      Slider(
                        max: 1000,
                        divisions: 10,
                        label: numberOfElements.toString(),
                        onChanged: (v) {
                          numberOfElements = (v).toInt();
                          setState(() {});
                        },
                        value: numberOfElements.toDouble(),
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
                                      .generateDataSet(minNumber, maxNumber,
                                          numberOfElements, onlyUniqueNumbers);
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
