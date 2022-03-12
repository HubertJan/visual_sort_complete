import 'dart:convert';

import 'package:http/http.dart';
import 'package:pysort_flutter/model/sort_result.dart';

import '../model/algorithm.dart';

const _url = "http://localhost:8000";

Future<List<int>> generateDataSet() async {
  final raw = await get(Uri.parse("$_url/dataSet/new"));
  final List<int> data =
      (json.decode(raw.body) as List).map((e) => e as int).toList();
  return data;
}

Future<SortResult> sortList(String algorithm, List<int> input) async {
  final inputJson = json.encode(input);
  final raw = await post(Uri.parse("$_url/dataSet/new"), body: inputJson);
  final sortResult = SortResult.fromJson(raw);
  return sortResult;
}

const supportedAlgorithms = {
  "Quicksort": "Das ist halt ziemlich schnell",
};
