import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/model/algorithm_step.dart';
import 'package:pysort_flutter/model/data_set.dart';
import 'package:pysort_flutter/providers/sort_graph_state.dart';
import 'package:pysort_flutter/providers/sort_config_state.dart';
import 'package:pysort_flutter/screens/widgets/algorithm_list_item.dart';
import 'package:pysort_flutter/side_bar/widgets/data_input_field.dart';
import 'package:pysort_flutter/screens/widgets/runtime_visualisation.dart';
import 'package:pysort_flutter/screens/widgets/sort_visualisation.dart';
import 'package:pysort_flutter/side_bar/side_bar.dart';
import 'package:resizable_widget/resizable_widget.dart';

import 'widgets/tabbed_view_example.dart';

class SortScreen extends StatelessWidget {
  const SortScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SideBar(),
          ChangeNotifierProxyProvider<SortConfig, SortGraphState?>(
            create: (ctx) {
              return null;
            },
            update: (BuildContext ctx, SortConfig sortConfig,
                SortGraphState? previousAlgorithmState) {
              if (sortConfig.shouldSort) {
                final random = Random();

                return SortGraphState(
                    steps: [
                      AlgorithmStep(from: 0, to: 2, doesMove: true),
                      AlgorithmStep(from: 1, to: 3, doesMove: true),
                      AlgorithmStep(from: 2, to: 1, doesMove: false),
                      AlgorithmStep(from: 4, to: 3, doesMove: true),
                      AlgorithmStep(from: 5, to: 2, doesMove: false)
                    ],
                    data: DataSet(List<int>.generate(
                        1000, (index) => random.nextInt(50))));
              }
              return previousAlgorithmState;
            },
            builder: (ctx, _) {
              return Expanded(
                child: ResizableWidget(
                  isHorizontalSeparator: true,
                  separatorSize: 2,
                  separatorColor: Colors.black45,
                  children: [
                    RuntimeVisualisation(),
                    SortVisualisation(),
                    TabbedViewExample(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
