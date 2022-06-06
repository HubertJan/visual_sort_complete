/* const supportedAlgorithms = {
  "Quicksort": '"Schnell"sortieren',
  "Mergesort": "teile und hersche",
  "Bubblesort": "Der Klassiker",
  "Selectionsort": "Ziemlich einfach",
  "Shellsort": "Sieht cool aus",
  "Heapsort": "Besseres Selectionsort",
}; */

import 'package:pysort_flutter/model/algorithm_step.dart';
import 'package:pysort_flutter/sort_tools/sort_algorithms/bubble_sort.dart';

final _supportedAlgorithms = [
  AlgorithmData(
    name: "Bubblesort",
    description: "Der Klassiker",
    sort: (list) {
      final sorted = [...list]..bubbleSort();
      return sorted;
    },
    sortWithAnalyzation: (list) {
      final sorted = [...list];
      final steps = sorted.bubbleSortWithAnalyzation();
      return SortedWithAnalyzation(
        sorted: sorted,
        steps: steps,
      );
    },
  )
];

class SortedWithAnalyzation {
  final List<AlgorithmStep> steps;
  final List<int> sorted;
  SortedWithAnalyzation({
    required this.steps,
    required this.sorted,
  });
}

List<AlgorithmData> get supportedAlgorithms {
  return [..._supportedAlgorithms];
}

class AlgorithmData {
  final String name;
  final String description;
  final List<int> Function(List<int>) sort;
  final SortedWithAnalyzation Function(List<int>) sortWithAnalyzation;

  AlgorithmData({
    required this.name,
    required this.description,
    required this.sort,
    required this.sortWithAnalyzation,
  });
}
