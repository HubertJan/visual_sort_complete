import 'package:pysort_flutter/model/algorithm_examination_result.dart';
import 'package:pysort_flutter/model/algorithm_step.dart';
import 'package:pysort_flutter/model/data_set.dart';
import 'package:pysort_flutter/sort_tools/measure_runtime.dart';

import 'supported_sort_algorithms.dart';

extension Examine on AlgorithmData {
  /// Only calculate and returns [AlgorithmStep]s for smallest [DataSet].
  Future<AlgorithmExaminationResult> examineAlgorithm(
    List<DataSet> dataSets,
  ) async {
    final runtimeResults = <String, Duration>{};
    final sortStepsPerDataSet = <String, List<AlgorithmStep>>{};
    for (final set in dataSets) {
      Duration totalRuntime = Duration.zero;
      int iterations = 0;
      while (totalRuntime < const Duration(seconds: 2) && iterations <= 50) {
        iterations += 1;
        final runtime = (() => sort(set.data)).callAndMeasureRuntime().runtime;
        totalRuntime = totalRuntime + runtime;
      }
      final averageRuntime =
          Duration(microseconds: totalRuntime.inMicroseconds ~/ iterations);
      runtimeResults[set.id] = averageRuntime;
      sortStepsPerDataSet[set.id] = sortWithAnalyzation(set.data).steps;
    }

    return AlgorithmExaminationResult(
      runtimePerDataSet: runtimeResults,
      sortStepsPerDataSet: sortStepsPerDataSet,
    );
  }
}
