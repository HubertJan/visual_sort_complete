import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/sort_config_state.dart';
import 'package:pysort_flutter/side_bar/widgets/data_input_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  Slider(
                    label: "Anzahl",
                    onChanged: (_) {},
                    value: 0.1,
                  ),
                  Slider(
                    label: "Anzahl",
                    onChanged: (_) {},
                    value: 0.1,
                  ),
                  Row(
                    children: [
                      Text("Doppelte Zahlen"),
                      Checkbox(value: true, onChanged: (_) {}),
                    ],
                  ),
                  TextButton(
                    child: Text("Datensatz generieren"),
                    onPressed: () async {
                      await Provider.of<SortConfig>(context, listen: false)
                          .generateDataSet();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
