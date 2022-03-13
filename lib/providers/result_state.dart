import 'package:flutter/cupertino.dart';
import 'package:pysort_flutter/model/data_set.dart';
import 'package:pysort_flutter/model/sort_result.dart';

import '../services/python_binder.dart' as python;

class ResultsState extends ChangeNotifier {
  final Map<String, SortResult> _results = {};
  bool _isFetching = false;

  bool get isFetching {
    return _isFetching;
  }

  Map<String, SortResult> get sortResults {
    return {..._results};
  }

  void setResults(Map<String, SortResult> newResult) {}

  Future<void> fetchResults(
      List<String> allSelectedAlgorithmName, DataSet dataSet) async {
    _isFetching = true;
    notifyListeners();
    final results = await python.sortList(allSelectedAlgorithmName, dataSet);
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

  Duration get longestRuntime {
    Duration dur = Duration.zero;
    for (final res in _results.values) {
      if (res.runtime > dur) {
        dur = res.runtime;
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
