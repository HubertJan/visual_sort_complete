import 'package:pysort_flutter/model/sort_result.dart';
import 'package:pysort_flutter/services/python_binder.dart';

class Algorithm {
  final String algorithmName;
  final String description;

  Future<SortResult> solveList(List<int> input) async {
    return await sortList(algorithmName, input);
  }

  Algorithm({
    required this.algorithmName,
    required this.description,
  });
}
