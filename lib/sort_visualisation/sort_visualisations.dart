import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/result_state.dart';
import 'package:pysort_flutter/providers/sort_graph_state.dart';
import 'package:tabbed_view/tabbed_view.dart';

import 'sort_visualisation.dart';
import 'sort_visualisation_tabbed_view.dart';

class SortVisualisations extends StatelessWidget {
  const SortVisualisations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultsState>(builder: (context, results, _) {
      final List<TabData> tabs = [];
      for (int i = 0; i < results.sortResults.entries.length; i += 1) {
        tabs.add(
          TabData(
              text: results.sortResults.entries.toList()[i].key,
              content: SortGraphStateProvider(resultStateIndex: i),
              keepAlive: true,
              closable: false),
        );
      }
      return SortVisualisationTabbedView(tabs: tabs);
    });
  }
}

class SortGraphStateProvider extends StatelessWidget {
  final int resultStateIndex;

  const SortGraphStateProvider({Key? key, required this.resultStateIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<ResultsState, SortGraphState?>(
      create: (ctx) {
        return null;
      },
      update: (BuildContext ctx, ResultsState results,
          SortGraphState? previousAlgorithmState) {
        if (!results.hasResults) {
          return null;
        }
        if (results.sortResults.entries.toList().length <= resultStateIndex) {
          return null;
        }

        final res =
            results.sortResults.entries.toList()[resultStateIndex].value;
        return SortGraphState(steps: res.steps, data: results.dataSets[0]);
      },
      builder: (ctx, _) {
        return const SortVisualisation();
      },
    );
  }
}
