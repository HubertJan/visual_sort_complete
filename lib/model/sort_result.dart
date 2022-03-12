import 'dart:core';

import 'package:pysort_flutter/model/algorithm_step.dart';

class SortResult {
/*   final RuntimeResult runtimeResult;
  final List<int> inputList; */
  late final List<AlgorithmStep> steps;
  late final String algorithmName;
  late final List<int> inputData;
  late final Duration runtime;

  SortResult({required this.steps});

  SortResult.fromJson(dynamic jsonData) {
    final stepsRaw = jsonData["steps"] as List;
    final steps = <AlgorithmStep>[];
    for (final step in stepsRaw) {
      steps.add(AlgorithmStep(
          doesMove: step["doesMove"], from: step["from"], to: step["to"]));
    }
    this.steps = steps;
    runtime = Duration(milliseconds: jsonData["runtime"]);
  }
}

class RuntimeResult {}
