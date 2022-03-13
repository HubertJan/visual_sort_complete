import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/result_state.dart';
import 'package:pysort_flutter/runtime_visualisation/runtime_graph_visualisation.dart';
import 'package:pysort_flutter/runtime_visualisation/runtime_visualisation.dart';
import 'package:pysort_flutter/sort_visualisation/sort_visualisation_tabbed_view.dart';
import 'package:tabbed_view/tabbed_view.dart';

class RuntimeVisualisations extends StatelessWidget {
  const RuntimeVisualisations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultsState>(builder: (context, results, _) {
      final List<TabData> tabs = [];
      tabs.add(
        TabData(
            text: "Balkendiagramm",
            content: RuntimeVisualisation(),
            keepAlive: true,
            closable: false),
      );
      tabs.add(
        TabData(
            text: "Graphen",
            content: RuntimeGraphVisualisation(),
            keepAlive: true,
            closable: false),
      );
      return SortVisualisationTabbedView(tabs: tabs);
    });
  }
}
