import 'dart:core';

import 'package:pysort_flutter/model/algorithm_step.dart';

import 'data_set.dart';

class SortResult {
/*   final RuntimeResult runtimeResult;
  final List<int> inputList; */
  late final List<AlgorithmStep> steps;
  late final DataSet inputData;
  late final Duration runtime;

  SortResult({required this.steps});

  SortResult.fromJson(dynamic jsonData, this.inputData) {
    final stepsRaw = jsonData["steps"] as List;
    final steps = <AlgorithmStep>[];
    for (final step in stepsRaw) {
      steps.add(AlgorithmStep.fromMap(Map.from(
          step.map((key, value) => MapEntry(key as String, value as int)))));
    }
    this.steps = steps;
    runtime = Duration(microseconds: jsonData["runtime"]);
  }
}

class RuntimeResult {}
