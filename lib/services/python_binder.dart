import 'dart:convert';

import 'package:http/http.dart';
import 'package:pysort_flutter/model/sort_result.dart';

import '../model/data_set.dart';

const _url = "http://localhost:8000";

Future<List<List<int>>> generateDataSet(
    int lowestValue,
    int heightValue,
    int lowLength,
    int highLength,
    int stepLength,
    bool onlyUniqueNumbers) async {
  final inputJson = json.encode({
    "minAmount": lowLength,
    "maxAmount": highLength,
    "stepAmount": stepLength,
    "min": lowestValue,
    "max": heightValue,
    "onlyUniqueNumbers": onlyUniqueNumbers
  });
  final raw = await post(Uri.parse("$_url/dataSets"), body: inputJson);
  final List<List> dataListRaw =
      (json.decode(raw.body) as List).map((e) => e as List).toList();
  final List<List<int>> dataList = [];
  for (final data in dataListRaw) {
    dataList.add(List.castFrom<dynamic, int>(data));
  }
  return dataList;
}

Future<List<SortResult>> sortList(
    List<String> algorithms, List<DataSet> input) async {
  final dataList = List.generate(input.length, (index) => input[index].data);
  final inputJson = json.encode({
    "algorithms": algorithms,
    "dataSet": dataList,
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
  "Shellsort": "Etwas",
  "Heapsort": "Heap, heap",
};
