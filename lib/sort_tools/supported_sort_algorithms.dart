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
import 'package:pysort_flutter/sort_tools/sort_algorithms/heap_sort.dart';
import 'package:pysort_flutter/sort_tools/sort_algorithms/merge_sort.dart';
import 'package:pysort_flutter/sort_tools/sort_algorithms/quick_sort.dart';
import 'package:pysort_flutter/sort_tools/sort_algorithms/selection_sort.dart';
import 'package:pysort_flutter/sort_tools/sort_algorithms/shell_sort.dart';

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
  ),
  AlgorithmData(
    name: "Selectionsort",
    description: "Ziemlich einfach",
    sort: (list) {
      final sorted = [...list]..selectionSort();
      return sorted;
    },
    sortWithAnalyzation: (list) {
      final sorted = [...list];
      final steps = sorted.selectionSortWithAnalyzation();
      return SortedWithAnalyzation(
        sorted: sorted,
        steps: steps,
      );
    },
  ),
  AlgorithmData(
    name: "Quicksort",
    description: '"Schnell"sortieren',
    sort: (list) {
      final sorted = [...list]..quickSort();
      return sorted;
    },
    sortWithAnalyzation: (list) {
      final sorted = [...list];
      final steps = sorted.quickSortWithAnalyzation();
      return SortedWithAnalyzation(
        sorted: sorted,
        steps: steps,
      );
    },
  ),
  AlgorithmData(
    name: "Mergesort",
    description: "Teile und hersche",
    sort: (list) {
      final sorted = [...list]..mergeSort();
      return sorted;
    },
    sortWithAnalyzation: (list) {
      final sorted = [...list];
      final steps = sorted.mergeSortAndCalculateSteps();
      return SortedWithAnalyzation(
        sorted: sorted,
        steps: steps,
      );
    },
  ),
  AlgorithmData(
    name: "Shellsort",
    description: "Sieht cool aus",
    sort: (list) {
      final sorted = [...list]..shellSort();
      return sorted;
    },
    sortWithAnalyzation: (list) {
      final sorted = [...list];
      final steps = sorted.shellSortAndCalculateSteps();
      return SortedWithAnalyzation(
        sorted: sorted,
        steps: steps,
      );
    },
  ),
  AlgorithmData(
    name: "Heapsort",
    description: "Besseres Selectionsort",
    sort: (list) {
      final sorted = [...list]..heapSort();
      return sorted;
    },
    sortWithAnalyzation: (list) {
      final sorted = [...list];
      final steps = sorted.heapSortAndCalculateSteps();
      return SortedWithAnalyzation(
        sorted: sorted,
        steps: steps,
      );
    },
  ),
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
