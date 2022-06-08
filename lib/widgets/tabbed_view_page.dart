import 'package:flutter/material.dart';
import 'package:tabbed_view/tabbed_view.dart';

class TabbedViewPage extends StatefulWidget {
  final List<TabData> tabs;

  const TabbedViewPage({Key? key, required this.tabs}) : super(key: key);

  @override
  _TabbedViewPageState createState() => _TabbedViewPageState();
}

class _TabbedViewPageState extends State<TabbedViewPage> {
  late TabbedViewController _controller;

  @override
  void didUpdateWidget(TabbedViewPage oldWidget) {
    _init();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _controller = TabbedViewController(widget.tabs);
  }

  @override
  Widget build(BuildContext context) {
    final theme = TabbedViewThemeData.dark();
    theme.tabsArea.color = Theme.of(context).colorScheme.background;
    theme.contentArea.padding = EdgeInsets.zero;
    TabbedView tabbedView = TabbedView(controller: _controller);
    return Scaffold(
        body: TabbedViewTheme(
      data: theme,
      child: tabbedView,
    ));
  }
}
