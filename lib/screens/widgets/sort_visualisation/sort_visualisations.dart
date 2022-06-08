import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/result_state.dart';
import 'package:pysort_flutter/providers/sort_graph_state.dart';
import 'package:tabbed_view/tabbed_view.dart';

import 'widgets/visualisation_bars.dart';
import 'widgets/visualisation_side_bar.dart';
import 'widgets/visualisation_tabbed_view.dart';

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
            content: SortGraphStateByResultStateProvider(
              resultStateIndex: i,
              builder: (ctx, _) {
                return Row(
                  children: const [
                    VisualisationBars(),
                    VisualisationSideBar(),
                  ],
                );
                ;
              },
            ),
            keepAlive: true,
            closable: false,
          ),
        );
      }
      return VisualisationTabbedView(tabs: tabs);
    });
  }
}

class SortGraphStateByResultStateProvider extends StatelessWidget {
  final int resultStateIndex;
  final Widget Function(BuildContext, Widget?)? builder;

  const SortGraphStateByResultStateProvider({
    Key? key,
    required this.resultStateIndex,
    this.builder,
  }) : super(key: key);

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
        return SortGraphState(
            steps: res.sortStepsPerDataSet.values.first,
            data: results.dataSets.firstWhere(
                (element) => element.id == res.sortStepsPerDataSet.keys.first));
      },
      builder: builder,
    );
  }
}
