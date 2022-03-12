import 'package:flutter/cupertino.dart';
import 'package:pysort_flutter/model/data_set.dart';
import 'package:pysort_flutter/model/sort_result.dart';
import 'package:pysort_flutter/providers/runtime_state.dart';
import 'package:pysort_flutter/providers/sort_graph_state.dart';

class ResultState extends ChangeNotifier {
  late final Map<String, SortGraphState> _algorithmToGraphState;
  late final Map<String, Duration> _algorithmRuntimes;

  ResultState({required List<SortResult> results}) {
    final Map<String, SortGraphState> algToState = {};
    final Map<String, Duration> algToDuration = {};
    for (final result in results) {
      algToState[result.algorithmName] =
          SortGraphState(steps: result.steps, data: DataSet(result.inputData));
      algToDuration[result.algorithmName] = result.runtime;
    }
    _algorithmToGraphState = algToState;
    _algorithmRuntimes = algToDuration;
  }
}
