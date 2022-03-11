import 'package:flutter/material.dart';
import 'package:pysort_flutter/model/algorithm_step.dart';
import 'package:pysort_flutter/model/data_set.dart';

class AlgorithmState extends ChangeNotifier {
  int _currentStep = 0;
  final List<AlgorithmStep> steps;
  final DataSet data;

  AlgorithmStep get currentStep {
    return steps[_currentStep];
  }

  int get currentStepIndex {
    return _currentStep;
  }

  void nextStep() {
    if (_currentStep < steps.length - 1) {
      _currentStep += 1;
      notifyListeners();
    }
  }

  AlgorithmState({required this.steps, required this.data});
}
