import 'package:flutter/material.dart';

import '../model/data_set.dart';

import 'python_binder.dart' as python;

class SortConfig extends ChangeNotifier {
  DataSet? _dataSet;
  List<String> _selectedAlgorithmName = [];
  bool _isReady = false;

  void startSorting() {
    _isReady = true;
    notifyListeners();
  }

  void hasSorted() {
    _isReady = false;
    notifyListeners();
  }

  bool get shouldSort {
    return _isReady;
  }

  List<String> get allSelectedAlgorithmName {
    return [..._selectedAlgorithmName];
  }

  set dataSet(DataSet? set) {
    _dataSet = set;
    notifyListeners();
  }

  Future<void> generateDataSet() async {
    dataSet = DataSet(await python.generateDataSet());
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
}
