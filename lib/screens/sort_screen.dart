import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/model/algorithm_step.dart';
import 'package:pysort_flutter/model/data_set.dart';
import 'package:pysort_flutter/providers/algorithm_setup_state.dart';
import 'package:pysort_flutter/providers/algorithm_state.dart';
import 'package:pysort_flutter/providers/data_set_provider.dart';
import 'package:pysort_flutter/screens/widgets/algorithm_list_item.dart';
import 'package:pysort_flutter/screens/widgets/data_input_field.dart';
import 'package:pysort_flutter/screens/widgets/sort_visualisation.dart';

class SortScreen extends StatelessWidget {
  const SortScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 500,
            height: 500,
            color: Color.fromRGBO(31, 33, 36, 1),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 400,
                        child: DateInputField(
                            text:
                                Provider.of<DataSetState>(context, listen: true)
                                    .text),
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
                                onPressed: () {
                                  Provider.of<DataSetState>(context,
                                          listen: false)
                                      .generate();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 500,
                  child: Consumer<AlgorithmsSetupState>(
                    builder: (ctx, state, _) {
                      return ListView.builder(
                        itemBuilder: (ctx, i) {
                          final alg = state.allAlgorithms[i];
                          final isSelected = state.isAlgorithmSelected(
                              state.allAlgorithms[i].algorithmName);
                          return AlgorithmListItem(
                            isSelected: isSelected,
                            title: alg.algorithmName,
                            description: alg.description,
                            onClick: !isSelected
                                ? () {
                                    state.selectAlgorithm(alg);
                                  }
                                : () {
                                    state.deselectAlgorithm(alg);
                                  },
                          );
                        },
                        itemCount: state.allAlgorithms.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          ChangeNotifierProvider<AlgorithmState>(
            create: (ctx) {
              return AlgorithmState(
                  steps: [
                    AlgorithmStep(from: 0, to: 2, doesMove: false),
                    AlgorithmStep(from: 0, to: 2, doesMove: false)
                  ],
                  data: DataSet([
                    3,
                    3,
                    2,
                    5,
                    12,
                  ]));
            },
            builder: (ctx, _) {
              return SortVisualisation();
            },
          ),
        ],
      ),
    );
  }
}
