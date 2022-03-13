import 'dart:convert';

import 'package:http/http.dart';
import 'package:pysort_flutter/model/sort_result.dart';

import '../model/data_set.dart';

const _url = "http://localhost:8000";

Future<List<int>> generateDataSet(int lowestValue, int heightValue, int length,
    bool onlyUniqueNumbers) async {
  final inputJson = json.encode({
    "amount": length,
    "min": lowestValue,
    "max": heightValue,
    "onlyUniqueNumbers": onlyUniqueNumbers
  });
  final raw = await post(Uri.parse("$_url/dataSet"), body: inputJson);
  final List<int> data =
      (json.decode(raw.body) as List).map((e) => e as int).toList();
  return data;
}

Future<List<SortResult>> sortList(
    List<String> algorithms, DataSet input) async {
  final inputJson = json.encode({
    "algorithms": algorithms,
    "dataSet": input.data,
  });
  final raw = await post(Uri.parse("$_url/evaluated"), body: inputJson /*  */
      );
  final sortResultsMapList = json.decode(raw.body);
  final List<SortResult> results = [];
  for (final sortResultMap in sortResultsMapList) {
    results.add(SortResult.fromJson(sortResultMap, input));
  }
  return results;
}

const supportedAlgorithms = {
  "Quicksort": "Best name ever",
  "Mergesort": "Stronk together",
  "Bubblesort": "Der Klassiker",
  "Selectionsort": "Sehr wählerisch",
};
