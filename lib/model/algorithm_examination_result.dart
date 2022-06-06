import 'package:pysort_flutter/model/algorithm_step.dart';

class AlgorithmExaminationResult {
  final Map<String, Duration> _runtimePerDataSet;
  final Map<String, List<AlgorithmStep>> _sortStepsPerDataSet;

  Map<String, Duration> get runtimePerDataSet {
    return {..._runtimePerDataSet};
  }

  Map<String, List<AlgorithmStep>> get sortStepsPerDataSet {
    return _sortStepsPerDataSet.map((key, value) => MapEntry(key, [...value]));
  }

  AlgorithmExaminationResult({
    required Map<String, Duration> runtimePerDataSet,
    required Map<String, List<AlgorithmStep>> sortStepsPerDataSet,
  })  : _runtimePerDataSet = runtimePerDataSet,
        _sortStepsPerDataSet = sortStepsPerDataSet;
}
