import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/result_state.dart';

import 'package:tabbed_view/tabbed_view.dart';

import '../sort_visualisation/widgets/sort_visualisation_tabbed_view.dart';
import 'widgets/runtime_visualisation.dart';
import 'widgets/runtime_graph_visualisation.dart';

class RuntimeVisualisations extends StatelessWidget {
  const RuntimeVisualisations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultsState>(builder: (context, results, _) {
      final List<TabData> tabs = [];
      tabs.add(
        TabData(
            text: "Balkendiagramm",
            content: const RuntimeVisualisation(),
            keepAlive: true,
            closable: false),
      );
      if (results.dataSets.length != 1) {
        tabs.add(
          TabData(
              text: "Graphen",
              content: const RuntimeGraphVisualisation(),
              keepAlive: true,
              closable: false),
        );
      }

      return SortVisualisationTabbedView(tabs: tabs);
    });
  }
}
