import 'package:flutter_test/flutter_test.dart';
import 'package:pysort_flutter/sort_tools/sort_algorithms/heap_sort.dart';
import 'package:pysort_flutter/sort_tools/sort_algorithms/merge_sort.dart';
import 'package:pysort_flutter/sort_tools/sort_algorithms/shell_sort.dart';

void main() {
  test("Check if MergeSort sorts correctly.", () {
    final data = [3, 2, 4, 1];
    data.mergeSort();
    expect(data, [1, 2, 3, 4]);
  });
  test("Check if ShellSort sorts correctly.", () {
    final data = [3, 2, 4, 1];
    data.shellSort();
    expect(data, [1, 2, 3, 4]);
  });

  test("Check if HeapSort sorts correctly.", () {
    final data = [3, 2, 4, 1];
    data.heapSort();
    expect(data, [1, 2, 3, 4]);
  });
}
