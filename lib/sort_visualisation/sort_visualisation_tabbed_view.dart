import 'package:flutter/material.dart';
import 'package:tabbed_view/tabbed_view.dart';

class SortVisualisationTabbedView extends StatefulWidget {
  final List<TabData> tabs;

  const SortVisualisationTabbedView({Key? key, required this.tabs})
      : super(key: key);

  @override
  _SortVisualisationTabbedViewState createState() =>
      _SortVisualisationTabbedViewState();
}

class _SortVisualisationTabbedViewState
    extends State<SortVisualisationTabbedView> {
  late TabbedViewController _controller;

  @override
  void didUpdateWidget(SortVisualisationTabbedView oldWidget) {
    _init();
    super.didUpdateWidget(oldWidget);
  }

  @override
  initState() {
    super.initState();
    _init();
  }

  void _init() {
    _controller = TabbedViewController(widget.tabs);
  }

  @override
  Widget build(BuildContext context) {
    final theme = TabbedViewThemeData.dark();
    theme.tabsArea.color = Colors.black;
    theme.contentArea..padding = EdgeInsets.zero;
    TabbedView tabbedView = TabbedView(controller: _controller);
    return Scaffold(
        body: TabbedViewTheme(
      data: theme,
      child: tabbedView,
    ));
  }
}
