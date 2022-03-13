import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/sort_config_state.dart';
import 'package:pysort_flutter/screens/sort_screen.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    final initialSize = Size(1000, 1000);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";

    win.show();
    win.maximize();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SortConfig>(
          create: (ctx) {
            return SortConfig();
          },
        ),
      ],
      builder: (context, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: Typography().white,
            primarySwatch: Colors.blue,
            colorScheme: const ColorScheme(
              primary: Colors.blue,
              secondary: Color.fromRGBO(255, 255, 0, 1),
              background: Color.fromRGBO(25, 28, 32, 1),
              surface: Color.fromRGBO(17, 17, 17, 1),
              error: Color.fromRGBO(220, 9, 9, 1),
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              onBackground: Colors.white,
              onError: Colors.white,
              onSurface: Colors.white,
              brightness: Brightness.light,
            ),
          ),
          home: SortScreen(),
        );
      },
    );
  }
}
