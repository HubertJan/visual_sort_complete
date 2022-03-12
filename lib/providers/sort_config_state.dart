import 'package:flutter/material.dart';

import '../model/data_set.dart';

import '../services/python_binder.dart' as python;

class SortConfig extends ChangeNotifier {
  DataSet? _dataSet;
  List<String> _selectedAlgorithmName = [];

  List<String> get allSelectedAlgorithmName {
    return [..._selectedAlgorithmName];
  }

  set dataSet(DataSet? set) {
    _dataSet = set;
    notifyListeners();
  }

  DataSet? get dataSet {
    return _dataSet;
  }

  bool isAlgorithmSelected(String algorithmName) {
    return _selectedAlgorithmName
            .indexWhere((element) => element == algorithmName) !=
        -1;
  }

  void selectAlgorithm(String algorithmName) {
    _selectedAlgorithmName.add(algorithmName);
    notifyListeners();
  }

  void deselectAlgorithm(String algorithmName) {
    _selectedAlgorithmName.removeWhere((element) => element == algorithmName);
    notifyListeners();
  }

  bool get isComplete {
    return _dataSet != null && _selectedAlgorithmName.length != 0;
  }

  Future<void> generateDataSet() async {
    dataSet = DataSet(await python.generateDataSet());
  }
}
