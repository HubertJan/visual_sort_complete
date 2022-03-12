import 'package:flutter/cupertino.dart';
import 'package:pysort_flutter/model/sort_result.dart';

class ResultsState extends ChangeNotifier {
  final Map<String, SortResult> _results = {};

  Map<String, SortResult> get sortResults {
    return {..._results};
  }

  void setResults(Map<String, SortResult> newResult) {
    _results.clear();
    _results.addAll(newResult);
    notifyListeners();
  }

  void clear() {
    _results.clear();
    notifyListeners();
  }

  bool get hasResults {
    return _results.isNotEmpty;
  }
}
