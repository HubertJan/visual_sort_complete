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

  SortResult.fromJson(Map<String, dynamic> jsonData, this.inputData) {
    runtime = Duration(microseconds: jsonData["runtime"]);
    // All this does, is converting a dynamic to List<Map<String, int?>>
    // Yes, it's pretty ugly.
    final rawSteps = List.castFrom<dynamic, List>(jsonData["steps"]);
    final lessRawSteps = <List<Map<String, int?>>>[];
    for (final rawSubStep in rawSteps) {
      final lessRawStep = List.castFrom<dynamic, Map>(rawSubStep);
      final lesslessRawStep = <Map<String, int?>>[];
      for (final rawMap in lessRawStep) {
        lesslessRawStep
            .add(Map.castFrom<dynamic, dynamic, String, int?>(rawMap));
      }
      lessRawSteps.add(lesslessRawStep);
    }
    final steps = <AlgorithmStep>[];
    for (final lessRawSteps in lessRawSteps) {
      steps.add(AlgorithmStep.fromList(lessRawSteps));
    }
    this.steps = steps;
  }
}

class RuntimeResult {}
