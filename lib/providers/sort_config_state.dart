import 'package:flutter/material.dart';

import '../model/data_set.dart';

import '../services/python_binder.dart' as python;

class SortConfig extends ChangeNotifier {
  List<DataSet> _dataSet = [];
  List<String> _selectedAlgorithmName = [];
  bool _hasBeenSolved = false;
  bool _isFetchingDataSet = false;

  bool get isFetchingDataSet {
    return _isFetchingDataSet;
  }

  List<String> get allSelectedAlgorithmName {
    return [..._selectedAlgorithmName];
  }

  void setSolved() {
    _hasBeenSolved = true;
    notifyListeners();
  }

  bool get hasBeenSolved {
    return _hasBeenSolved;
  }

  List<DataSet> get dataSet {
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
    return _dataSet.isNotEmpty && _selectedAlgorithmName.isNotEmpty;
  }

  Future<void> generateDataSet(int lowestValue, int heightValue, int lowLength,
      int heightLength, int stepLength, bool onlyUniqueNumbers) async {
    _dataSet = [];
    _hasBeenSolved = false;
    _isFetchingDataSet = true;
    notifyListeners();
    final dataSetsRaw = await python.generateDataSet(lowestValue, heightValue,
        lowLength, heightLength, stepLength, onlyUniqueNumbers);
    for (final set in dataSetsRaw) {
      _dataSet.add(DataSet(set, heightValue));
    }
    _isFetchingDataSet = false;
    notifyListeners();
  }
}
