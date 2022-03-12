import 'package:flutter/material.dart';
import 'package:pysort_flutter/screens/widgets/runtime_visualisation.dart';
import 'package:pysort_flutter/screens/widgets/sort_visualisation.dart';
import 'package:tabbed_view/tabbed_view.dart';

class TabbedViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: TabbedViewExamplePage());
  }
}

class TabbedViewExamplePage extends StatefulWidget {
  @override
  _TabbedViewExamplePageState createState() => _TabbedViewExamplePageState();
}

class _TabbedViewExamplePageState extends State<TabbedViewExamplePage> {
  late TabbedViewController _controller;

  @override
  void initState() {
    super.initState();
    List<TabData> tabs = [];

    tabs.add(TabData(
        text: 'Tab 1',
        content: Padding(child: Text('Hello'), padding: EdgeInsets.all(8))));
    tabs.add(
      TabData(
        text: 'Tab 2',
        content: RuntimeVisualisation(),
      ),
    );
    tabs.add(
      TabData(
          text: 'TextField',
          content: const Padding(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
              ),
            ),
            padding: EdgeInsets.all(8),
          ),
          keepAlive: true),
    );

    _controller = TabbedViewController(tabs);
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
