import 'package:pysort_flutter/model/algorithm_step.dart';

extension QuickSort on List<int> {
  void quickSort() {
    _quickSort();
  }

  List<AlgorithmStep>? _quickSort({bool isAnalyzing = false}) {
    final steps = <AlgorithmStep>[];
    final sections = [
      [0, length - 1]
    ];
    while (sections.isNotEmpty) {
      final currentSection = sections.last;
      sections.removeLast();
      final pivotValue = this[(currentSection[0] + currentSection[1]) ~/ 2];
      final sectionDividerIndex = _quickSortSection(
          currentSection[0], currentSection[1], pivotValue, steps,
          isAnalyzing: isAnalyzing);
      if (sectionDividerIndex == null) {
        break;
      }
      if (currentSection[0] != sectionDividerIndex) {
        sections.add([currentSection[0], sectionDividerIndex]);
      }
      if (currentSection[1] - 1 != sectionDividerIndex) {
        sections.add([sectionDividerIndex + 1, currentSection[1]]);
      }
    }

    if (isAnalyzing) {
      return steps;
    }
    return null;
  }

  int? _quickSortSection(int sectionStartIndex, int sectionEndIndex,
      int pivotValue, List<AlgorithmStep> steps,
      {bool isAnalyzing = false}) {
    final sectionLength = sectionEndIndex + 1;
    int leftSectionEndIndex = sectionStartIndex;
    int rightSectionStartIndex = sectionEndIndex;
    while (leftSectionEndIndex <= rightSectionStartIndex) {
      while (sectionLength > leftSectionEndIndex &&
          this[leftSectionEndIndex] < pivotValue) {
        leftSectionEndIndex += 1;
      }
      while (rightSectionStartIndex >= 0 &&
          pivotValue < this[rightSectionStartIndex]) {
        rightSectionStartIndex -= 1;
      }
      if (leftSectionEndIndex <= rightSectionStartIndex) {
        if (isAnalyzing) {
          steps.add(SwapAlgorithmStep(
              firstElementIndex: leftSectionEndIndex,
              secondElementIndex: rightSectionStartIndex));
        }
        final temp = this[leftSectionEndIndex];
        this[leftSectionEndIndex] = this[rightSectionStartIndex];
        this[rightSectionStartIndex] = temp;
        leftSectionEndIndex += 1;
        rightSectionStartIndex -= 1;
      }
    }
    if (sectionStartIndex < rightSectionStartIndex) {
      return rightSectionStartIndex;
    }
    if (leftSectionEndIndex < sectionLength) {
      return leftSectionEndIndex - 1;
    }
    return null;
  }

  List<AlgorithmStep> quickSortWithAnalyzation() {
    return _quickSort(isAnalyzing: true)!;
  }
}
