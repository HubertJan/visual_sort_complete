import 'package:pysort_flutter/model/algorithm_step.dart';

extension BubbleSort on List<int> {
  void bubbleSort() {
    _bubbleSort();
  }

  List<AlgorithmStep>? _bubbleSort({bool isAnalyzing = false}) {
    final steps = <AlgorithmStep>[];
    for (int iteration = length; iteration > 1; iteration--) {
      for (int elementIndex = 0; elementIndex < iteration - 1; elementIndex++) {
        if (this[elementIndex] > this[elementIndex + 1]) {
          if (isAnalyzing) {
            steps.add(
              SwapAlgorithmStep(
                  firstElementIndex: elementIndex,
                  secondElementIndex: elementIndex + 1),
            );
          }
          final temp = this[elementIndex + 1];
          this[elementIndex + 1] = this[elementIndex];
          this[elementIndex] = temp;
        }
      }
    }
    if (isAnalyzing) {
      return steps;
    }
    return null;
  }

  List<AlgorithmStep> bubbleSortWithAnalyzation() {
    return _bubbleSort(isAnalyzing: true)!;
  }
}
