import 'package:flutter/cupertino.dart';
import 'package:pysort_flutter/model/data_set.dart';
import 'package:pysort_flutter/model/sort_result.dart';

import '../services/python_binder.dart' as python;

class ResultsState extends ChangeNotifier {
  final Map<String, SortResult> _results = {};
  final List<DataSet> _dataSets = [];
  bool _isFetching = false;

  bool get isFetching {
    return _isFetching;
  }

  Map<String, SortResult> get sortResults {
    return {..._results};
  }

  List<DataSet> get dataSets {
    return [..._dataSets];
  }

  void setResults(Map<String, SortResult> newResult) {}

  Future<void> fetchResults(
      List<String> allSelectedAlgorithmName, List<DataSet> dataSets) async {
    _isFetching = true;
    notifyListeners();
    final results = await python.sortList(allSelectedAlgorithmName, dataSets);
    _dataSets.clear();
    _dataSets.addAll(dataSets);
    final Map<String, SortResult> algorithmNameToResult = {};
    for (int i = 0; i < results.length; i += 1) {
      algorithmNameToResult.addAll(
        {
          allSelectedAlgorithmName[i]: results[i],
        },
      );
    }
    _results.clear();
    _results.addAll(algorithmNameToResult);
    _isFetching = false;
    notifyListeners();
  }

  Duration longestRuntimeOf(int dataSetLength) {
    Duration dur = Duration.zero;
    for (final res in _results.values) {
      if (res.runtimes[dataSetLength]! > dur) {
        dur = res.runtimes[dataSetLength]!;
      }
    }
    return dur;
  }

  void clear() {
    _results.clear();
    notifyListeners();
  }

  bool get hasResults {
    return _results.isNotEmpty;
  }
}
