import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/sort_config_state.dart';
import 'package:pysort_flutter/screens/widgets/algorithm_list_item.dart';
import 'package:pysort_flutter/side_bar/widgets/data_setup.dart';

import '../providers/python_binder.dart' as python;

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                ElevatedButton(
                  child: Icon(
                    Icons.play_arrow,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          DatasetSetup(),
          Container(
            height: 500,
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
  }
}
