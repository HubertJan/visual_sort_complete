import 'dart:convert';

import 'package:http/http.dart';
import 'package:pysort_flutter/model/sort_result.dart';

import '../model/data_set.dart';

const _url = "http://localhost:8000";

Future<List<int>> generateDataSet(
    int lowestValue, int heightValue, int length) async {
  final inputJson =
      json.encode({"amount": length, "min": lowestValue, "max": heightValue});
  final raw = await post(Uri.parse("$_url/dataSet"), body: inputJson);
  final List<int> data =
      (json.decode(raw.body) as List).map((e) => e as int).toList();
  return data;
}

Future<SortResult> sortList(String algorithm, DataSet input) async {
  final inputJson = json.encode(input.data);
  final raw = await post(Uri.parse("$_url/${algorithm}"), body: inputJson /*  */
      );
  final sortResult = SortResult.fromJson(json.decode(raw.body), input);
  return sortResult;
}

const supportedAlgorithms = {
  "Quicksort": "Das ist halt ziemlich schnell",
};
