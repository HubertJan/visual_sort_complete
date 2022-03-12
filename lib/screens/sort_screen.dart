import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/model/algorithm_step.dart';
import 'package:pysort_flutter/model/data_set.dart';
import 'package:pysort_flutter/providers/sort_graph_state.dart';
import 'package:pysort_flutter/providers/sort_config_state.dart';
import 'package:pysort_flutter/screens/widgets/runtime_visualisation.dart';
import 'package:pysort_flutter/screens/widgets/sort_visualisation.dart';
import 'package:pysort_flutter/side_bar/side_bar.dart';
import 'package:pysort_flutter/widgets/custom_windows_border.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../providers/result_state.dart';
import 'widgets/tabbed_view_example.dart';

class SortScreen extends StatelessWidget {
  const SortScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomWindowsBorder(
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider<SortConfig>(
                create: (ctx) {
                  return SortConfig();
                },
              ),
              ChangeNotifierProvider<ResultsState?>(
                create: (ctx) {
                  return ResultsState();
                },
              )
            ],
            builder: (context, snapshot) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SideBar(),
                  Expanded(
                    child: ResizableWidget(
                      isHorizontalSeparator: true,
                      separatorSize: 2,
                      separatorColor: Colors.black45,
                      children: [
                        /*      RuntimeVisualisation(), */
                        SortVisualisation(),
                        /*                    TabbedViewExample(), */
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
