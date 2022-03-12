import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/result_state.dart';
import 'package:pysort_flutter/providers/sort_config_state.dart';
import 'package:pysort_flutter/side_bar/widgets/algorithm_list_item.dart';
import 'package:pysort_flutter/side_bar/widgets/data_setup.dart';

import '../services/python_binder.dart' as python;

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SortConfig>(builder: (context, state, _) {
      return Container(
        width: 500,
        height: 500,
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            Container(
              height: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !state.hasBeenSolved
                      ? ElevatedButton(
                          child: Icon(
                            Icons.play_arrow,
                          ),
                          onPressed: Provider.of<SortConfig>(context).isComplete
                              ? () async {
                                  final results = await python.sortList(
                                      state.allSelectedAlgorithmName[0],
                                      state.dataSet!);
                                  Provider.of<ResultsState>(context,
                                          listen: false)
                                      .setResults({
                                    state.allSelectedAlgorithmName[0]: results
                                  });
                                  state.setSolved();
                                }
                              : null,
                        )
                      : const Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                ],
              ),
            ),
            DatasetSetup(),
            Expanded(
              child: Consumer<SortConfig>(
                builder: (ctx, state, _) {
                  return ListView.builder(
                    itemBuilder: (ctx, i) {
                      final alg = python.supportedAlgorithms.keys.toList()[i];
                      final isSelected = state.isAlgorithmSelected(alg);
                      return AlgorithmListItem(
                        isSelected: isSelected,
                        title: alg,
                        description: python.supportedAlgorithms[alg] ?? "",
                        onClick: !isSelected
                            ? () {
                                state.selectAlgorithm(alg);
                              }
                            : () {
                                state.deselectAlgorithm(alg);
                              },
                      );
                    },
                    itemCount: python.supportedAlgorithms.length,
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
