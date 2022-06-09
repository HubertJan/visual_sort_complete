import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/sort_config_state.dart';
import 'package:pysort_flutter/widgets/custom_windows_border.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../providers/result_state.dart';
import 'widgets/runtime_visualisation/runtime_visualisations.dart';
import 'widgets/side_bar/side_bar.dart';
import 'widgets/sort_visualisation/sort_visualisations.dart';

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
              ChangeNotifierProvider<ResultsState>(
                create: (ctx) {
                  return ResultsState();
                },
              )
            ],
            builder: (context, snapshot) {
              return Row(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Consumer<ResultsState>(
                      builder: (ctx, state, _) {
                        if (state.isFetching) {
                          return Container(
                            color: Theme.of(context).colorScheme.surface,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (!state.hasResults) {
                          return Container(
                            color: Theme.of(context).colorScheme.surface,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "VisualSort Complete",
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    Text(
                                      "Flutter Sortiervisualisierung",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return ResizableWidget(
                          isHorizontalSeparator: true,
                          separatorSize: 6,
                          separatorColor: Colors.black45,
                          children: const [
                            RuntimeVisualisations(),
                            SortVisualisations(),
                          ],
                        );
                      },
                    ),
                  ),
                  const SideBar(),
                ],
              );
            }),
      ),
    );
  }
}
