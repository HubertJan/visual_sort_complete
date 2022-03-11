import 'dart:ffi';
import 'package:ffi/ffi.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/algorithm_setup_state.dart';
import 'package:pysort_flutter/providers/data_set_provider.dart';
import 'package:pysort_flutter/screens/sort_screen.dart';

import 'package:dartpy/dartpy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AlgorithmsSetupState>(
          create: (ctx) {
            return AlgorithmsSetupState();
          },
        ),
        ChangeNotifierProvider<DataSetState>(
          create: (ctx) {
            return DataSetState();
          },
        ),
      ],
      builder: (context, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: Typography().white,
            primarySwatch: Colors.blue,
          ),
          home: SortScreen(),
        );
      },
    );
  }
}
