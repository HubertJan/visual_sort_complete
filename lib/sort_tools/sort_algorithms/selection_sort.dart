import 'package:pysort_flutter/model/algorithm_step.dart';

extension SelectionSort on List<int> {
  void selectionSort() {
    _selectionSort();
  }

  List<AlgorithmStep>? _selectionSort({bool isAnalyzing = false}) {
    final steps = <AlgorithmStep>[];
    for (int index = 0; index < length; index++) {
      int minValueIndex = index;
      for (int i = index + 1; i < length; i++) {
        if (this[i] < this[minValueIndex]) {
          minValueIndex = i;
        }
      }
      if (isAnalyzing) {
        steps.add(SwapAlgorithmStep(
            firstElementIndex: index, secondElementIndex: minValueIndex));
      }
      final temp = this[index];
      this[index] = this[minValueIndex];
      this[minValueIndex] = temp;
    }
    if (isAnalyzing) {
      return steps;
    }
    return null;
  }

  List<AlgorithmStep> selectionSortWithAnalyzation() {
    return _selectionSort(isAnalyzing: true)!;
  }
}
