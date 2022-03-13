import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pysort_flutter/providers/result_state.dart';
import 'package:pysort_flutter/providers/sort_config_state.dart';
import 'package:pysort_flutter/side_bar/widgets/algorithm_list_item.dart';
import 'package:pysort_flutter/side_bar/widgets/data_setup.dart';

import '../services/python_binder.dart' as python;
import 'widgets/side_bar_title_bar.dart';

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
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !state.hasBeenSolved
                      ? ElevatedButton(
                          child: const Icon(
                            Icons.play_arrow,
                          ),
                          onPressed: Provider.of<SortConfig>(context).isComplete
                              ? () async {
                                  await Provider.of<ResultsState>(context,
                                          listen: false)
                                      .fetchResults(
                                          state.allSelectedAlgorithmName,
                                          state.dataSet);
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
            const DatasetSetup(),
            const SideBarTitleBar(
              title: "Algorithmen",
            ),
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
