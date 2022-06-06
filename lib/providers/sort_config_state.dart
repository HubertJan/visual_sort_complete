import 'package:flutter/material.dart';

import '../model/data_set.dart';

class SortConfig extends ChangeNotifier {
  List<DataSet> _dataSet = [];
  final List<String> _selectedAlgorithmName = [];
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

  Future<void> generateDataSet({
    required int lowestValue,
    required int highestValue,
    required int initialAmount,
    required int maxAmount,
    required int amountIncreasePerDataSet,
    required bool onlyUniqueNumbers,
  }) async {
    _dataSet = [];
    _hasBeenSolved = false;
    _isFetchingDataSet = true;
    notifyListeners();
    _dataSet = <DataSet>[]..addGeneratedDataSets(
        highestValue: highestValue,
        amountIncreasePerDataSet: amountIncreasePerDataSet,
        maxAmount: maxAmount,
        initialAmount: initialAmount,
        lowestValue: lowestValue,
        onlyUniqueNumbers: onlyUniqueNumbers,
      );
    _isFetchingDataSet = false;
    notifyListeners();
  }
}
