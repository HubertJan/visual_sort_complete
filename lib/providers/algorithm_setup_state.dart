import 'package:flutter/material.dart';
import 'package:pysort_flutter/model/algorithm.dart';

class AlgorithmsSetupState extends ChangeNotifier {
  List<Algorithm> _algorithms = [];
  List<Algorithm> get allAlgorithms {
    return [
      Algorithm(
        algorithmName: "QuickSort",
        description: "description",
      )
    ];
  }

  bool isAlgorithmSelected(String algorithmName) {
    for (final alg in _algorithms) {
      if (alg.algorithmName == algorithmName) {
        return true;
      }
    }
    return false;
  }

  void selectAlgorithm(Algorithm algorithm) {
    _algorithms.add(algorithm);
    notifyListeners();
  }

  void deselectAlgorithm(Algorithm algorithm) {
    final index = _algorithms.indexWhere(
        (element) => element.algorithmName == algorithm.algorithmName);

    _algorithms.removeAt(index);
    notifyListeners();
  }
}
