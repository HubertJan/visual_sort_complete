import 'package:flutter/material.dart';
import 'package:pysort_flutter/model/data_set.dart';

import "python_binder.dart" as python;

class DataSetState extends ChangeNotifier {
  DataSet? _set;

  void generate() async {
    final data = await python.generateDataSet();
    _set = DataSet(data);
    notifyListeners();
  }

  String get text {
    return _set?.asString() ?? "";
  }
}
