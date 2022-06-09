import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pysort_flutter/model/algorithm_step.dart';
import 'package:pysort_flutter/model/data_set.dart';

class SortGraphState extends ChangeNotifier {
  int _currentStep = 0;
  final Map<String, List<AlgorithmStep>> _dataSetIdToSteps;
  Duration _durationPerStep = const Duration(milliseconds: 1);
  bool? _isAutoPlayForward;

// TODO: Buggy. Total Sort Duration does not equal the execution time.
  set durationPerStep(Duration time) {
    _durationPerStep = time;
    if (isAutoPlay) {
      _autoPlayTimer!.cancel();
      startAutoPlay(isForwards: _isAutoPlayForward!);
    }
    notifyListeners();
  }

  Duration get durationPerStep {
    return _durationPerStep;
  }

  final List<DataSet> _dataSets;

  List<DataSet> get dataSets {
    return [..._dataSets];
  }

  DataSet get currentDataSet {
    return _dataSets
        .firstWhere((element) => element.id == _currentSelectedDataSetId);
  }

  String _currentSelectedDataSetId;
  List<int> _elementList = [];

  List<AlgorithmStep> get _steps {
    return _dataSetIdToSteps[_currentSelectedDataSetId]!;
  }

  AlgorithmStep? get currentStep {
    return _steps.length > _currentStep ? _steps[_currentStep] : null;
  }

  List<AlgorithmStep> get steps {
    return [..._steps];
  }

  bool get isLastStep {
    return currentStepIndex == _steps.length;
  }

  int get currentStepIndex {
    return _currentStep;
  }

  void switchDataSet(String id) {
    if (!_dataSetIdToSteps.keys.contains(id)) {
      throw ArgumentError("DataSet with $id does not exist in SortGraphState.");
    }
    _currentSelectedDataSetId = id;
    _autoPlayTimer?.cancel();
    _currentStep = 0;
    _elementList = currentDataSet.data;
    notifyListeners();
  }

  String get currentDataSetId {
    return _currentSelectedDataSetId;
  }

  List<int> get elementList => _elementList;

  void nextStep() {
    if (!isLastStep) {
      _elementList = currentStep?.doStep(_elementList) ?? _elementList;
      _currentStep += 1;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep != 0) {
      _currentStep -= 1;
      _elementList = currentStep?.undoStep(_elementList) ?? _elementList;
      notifyListeners();
    }
  }

  Timer? _autoPlayTimer;

  bool get isAutoPlay {
    return _autoPlayTimer?.isActive ?? false;
  }

  bool get canNext {
    return !isLastStep && !isAutoPlay;
  }

  bool get canPrevious {
    return currentStepIndex != 0 && !isAutoPlay;
  }

  void stopAutoPlay() {
    _autoPlayTimer?.cancel();
    notifyListeners();
  }

  void startAutoPlay({bool isForwards = true}) {
    if (isAutoPlay == true) {
      return;
    }
    _isAutoPlayForward = isForwards;
    _autoPlayTimer = Timer.periodic(
      _durationPerStep,
      (Timer timer) {
        if (isForwards) {
          if (isLastStep) {
            nextStep();
            _autoPlayTimer?.cancel();
            notifyListeners();
          } else {
            nextStep();
            notifyListeners();
          }
          return;
        }
        if (currentStepIndex == 0) {
          previousStep();
          _autoPlayTimer?.cancel();
          notifyListeners();
        } else {
          previousStep();
          notifyListeners();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _autoPlayTimer?.cancel();
  }

  SortGraphState(
      {required Map<String, List<AlgorithmStep>> solveStepsPerDataSet,
      required List<DataSet> dataSets})
      : _dataSetIdToSteps = solveStepsPerDataSet,
        _currentSelectedDataSetId = solveStepsPerDataSet.keys.first,
        _dataSets = dataSets,
        _elementList = dataSets
            .firstWhere(
                (element) => element.id == solveStepsPerDataSet.keys.first)
            .data;
}
