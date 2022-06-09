import 'package:flutter/foundation.dart';
import 'package:pysort_flutter/model/algorithm_examination_result.dart';
import 'package:pysort_flutter/model/data_set.dart';
import 'package:pysort_flutter/sort_tools/examine_algorithm.dart';

import '../sort_tools/supported_sort_algorithms.dart';

class ResultsState extends ChangeNotifier {
  final Map<String, AlgorithmExaminationResult> _algorithnmNameToResults = {};
  final List<DataSet> _dataSets = [];
  bool _isFetching = false;

  bool get isFetching {
    return _isFetching;
  }

  Map<String, AlgorithmExaminationResult> get sortResults {
    return {..._algorithnmNameToResults};
  }

  List<DataSet> get dataSets {
    return [..._dataSets];
  }

  Future<void> fetchResults(
    List<String> allSelectedAlgorithmName,
    List<DataSet> dataSets,
  ) async {
    _isFetching = true;
    notifyListeners();
    _dataSets.clear();
    _dataSets.addAll(dataSets);
    final results = <String, AlgorithmExaminationResult>{};
    for (final algorithmName in allSelectedAlgorithmName) {
      final algorithm = supportedAlgorithms
          .firstWhere((element) => element.name == algorithmName);

      results[algorithm.name] =
          await compute(algorithm.examineAlgorithm, dataSets);
    }
    _algorithnmNameToResults.clear();
    _algorithnmNameToResults.addAll(results);
    _isFetching = false;
    notifyListeners();
  }

  Duration calculateLongestRuntime({required int dataSetLength}) {
    final validDataSets =
        _dataSets.where((element) => element.data.length == dataSetLength);
    if (validDataSets.isEmpty) {
      throw ArgumentError("No DataSet with $dataSetLength Length was found.");
    }
    Duration dur = Duration.zero;
    for (final entry in _algorithnmNameToResults.entries) {
      final result = entry.value;
      for (final set in result.runtimePerDataSet.entries.where(
        (entry) => validDataSets.any((element) => element.id == entry.key),
      )) {
        if (set.value > dur) {
          dur = set.value;
        }
      }
    }
    return dur;
  }

  void clear() {
    _algorithnmNameToResults.clear();
    notifyListeners();
  }

  bool get hasResults {
    return _algorithnmNameToResults.isNotEmpty;
  }
}
