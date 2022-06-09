import 'dart:math';

import 'package:pysort_flutter/model/algorithm_step.dart';

extension MergeSort on List<int> {
  void mergeSort() {
    _mergeSort(isAnalyzing: false);
  }

  List<AlgorithmStep> mergeSortAndCalculateSteps() {
    return _mergeSort(isAnalyzing: true)!;
  }

  List<AlgorithmStep>? _mergeSort({bool isAnalyzing = false}) {
    final steps = isAnalyzing ? <AlgorithmStep>[] : null;
    for (int subListSize = 1;
        subListSize <= length - 1;
        subListSize = 2 * subListSize) {
      for (int leftStart = 0;
          leftStart < length - 1;
          leftStart += 2 * subListSize) {
        final mid = min(leftStart + subListSize - 1, length - 1);

        final rightEnd = min(leftStart + 2 * subListSize - 1, length - 1);

        final res = _mergeSortTwoSections(
          leftStartIndex: leftStart,
          middleIndex: mid + 1,
          rightEndIndex: rightEnd,
          isAnalyzing: isAnalyzing,
        );

        steps?.addAll(res!);
      }
    }
    return steps;
  }

  List<AlgorithmStep>? _mergeSortTwoSections({
    required int leftStartIndex,
    required int middleIndex,
    required int rightEndIndex,
    bool isAnalyzing = false,
  }) {
    final steps = isAnalyzing ? <AlgorithmStep>[] : null;
    final leftSection = sublist(leftStartIndex, middleIndex);
    final rightSection = sublist(middleIndex, rightEndIndex + 1);

    int currentIndexLeftSection = 0;
    int currentIndexRightSection = 0;
    int currentIndexTotal = leftStartIndex;
    final subSteps = isAnalyzing ? <AlgorithmSubStep>[] : null;
    while (currentIndexLeftSection < leftSection.length &&
        currentIndexRightSection < rightSection.length) {
      if (leftSection[currentIndexLeftSection] <=
          rightSection[currentIndexRightSection]) {
        subSteps?.add(AlgorithmSubStep(
            index: currentIndexTotal,
            barType: 10,
            beforeChangeValue: this[currentIndexTotal],
            newValue: leftSection[currentIndexLeftSection]));
        this[currentIndexTotal] = leftSection[currentIndexLeftSection];
        currentIndexLeftSection++;
      } else {
        subSteps?.add(AlgorithmSubStep(
            index: currentIndexTotal,
            barType: 10,
            beforeChangeValue: this[currentIndexTotal],
            newValue: leftSection[currentIndexLeftSection]));
        this[currentIndexTotal] = rightSection[currentIndexRightSection];
        currentIndexRightSection++;
      }
      currentIndexTotal++;
    }
    steps?.add(AlgorithmStep(subSteps: subSteps!));

    final remainingElementsCountOfLeftSection =
        leftSection.length - currentIndexLeftSection;
    final remainingElementsCountOfRightSection =
        rightSection.length - currentIndexRightSection;

    final replaceStepsLeft = _replaceRangeAndCalculateSteps(
        currentIndexTotal,
        currentIndexTotal + remainingElementsCountOfLeftSection,
        leftSection.sublist(currentIndexLeftSection));
    steps?.addAll(replaceStepsLeft);
    final replaceStepsRight = _replaceRangeAndCalculateSteps(
        currentIndexTotal,
        currentIndexTotal + remainingElementsCountOfRightSection,
        rightSection.sublist(currentIndexRightSection));
    steps?.addAll(replaceStepsRight);

    return steps;
  }

  List<AlgorithmStep> _replaceRangeAndCalculateSteps(
    int start,
    int end,
    Iterable<int> replacements,
  ) {
    final replacementsList = replacements.toList();
    final steps = <AlgorithmStep>[];
    for (int index = start; index < end; index++) {
      steps.add(
        AlgorithmStep(subSteps: [
          AlgorithmSubStep(
            barType: 10,
            index: index,
            beforeChangeValue: this[index],
            newValue: replacementsList[index - start],
          )
        ]),
      );
      this[index] = replacementsList[index - start];
    }
    return steps;
  }
}
