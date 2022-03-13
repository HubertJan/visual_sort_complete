import 'dart:core';

import 'package:pysort_flutter/model/algorithm_step.dart';
import 'package:pysort_flutter/model/data_set.dart';

class SortResult {
  final List<AlgorithmStep> _steps = [];
  final Map<int, Duration> _runtimes = {};

  List<AlgorithmStep> get steps {
    return [..._steps];
  }

  Map<int, Duration> get runtimes {
    return {..._runtimes};
  }

  SortResult.fromJson(Map<String, dynamic> jsonData, List<DataSet> inputData) {
    final runtimes = List.castFrom<dynamic, int>(jsonData["runtimes"] as List);
    for (int i = 0; i < runtimes.length; i += 1) {
      _runtimes[inputData[i].data.length] = Duration(microseconds: runtimes[i]);
    }

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
    _steps.addAll(steps);
  }
}

class RuntimeResult {}
