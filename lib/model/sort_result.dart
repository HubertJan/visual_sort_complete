import 'dart:core';

import 'package:pysort_flutter/model/algorithm_step.dart';
import 'package:pysort_flutter/providers/algorithm_setup_state.dart';

class SortResult {
/*   final RuntimeResult runtimeResult;
  final List<int> inputList; */
  late final List<AlgorithmStep> steps;

  SortResult({required this.steps});

  SortResult.fromJson(dynamic jsonData) {
    final stepsRaw = jsonData["steps"] as List;
    final steps = <AlgorithmStep>[];
    for (final step in stepsRaw) {
      steps.add(AlgorithmStep(
          doesMove: step["doesMove"], from: step["from"], to: step["to"]));
    }
    this.steps = steps;
  }
}

class RuntimeResult {}
