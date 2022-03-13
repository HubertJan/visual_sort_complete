import 'package:flutter/material.dart';

import '../model/data_set.dart';

import '../services/python_binder.dart' as python;

class SortConfig extends ChangeNotifier {
  DataSet? _dataSet;
  List<String> _selectedAlgorithmName = [];
  bool _hasBeenSolved = false;

  List<String> get allSelectedAlgorithmName {
    return [..._selectedAlgorithmName];
  }

  set dataSet(DataSet? set) {
    _dataSet = set;
    _hasBeenSolved = false;
    notifyListeners();
  }

  void setSolved() {
    _hasBeenSolved = true;
    notifyListeners();
  }

  bool get hasBeenSolved {
    return _hasBeenSolved;
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
    _hasBeenSolved = false;
    notifyListeners();
  }

  void deselectAlgorithm(String algorithmName) {
    _selectedAlgorithmName.removeWhere((element) => element == algorithmName);
    _hasBeenSolved = false;
    notifyListeners();
  }

  bool get isComplete {
    return _dataSet != null && _selectedAlgorithmName.length != 0;
  }

  Future<void> generateDataSet(int lowestValue, int heightValue, int length,
      bool onlyUniqueNumbers) async {
    dataSet = DataSet(
        await python.generateDataSet(
            lowestValue, heightValue, length, onlyUniqueNumbers),
        heightValue);
  }
}
