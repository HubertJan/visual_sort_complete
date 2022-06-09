import 'package:pysort_flutter/model/algorithm_step.dart';

extension ShellSort on List<int> {
  void shellSort() {
    _shellSort(isAnalyzing: false);
  }

  List<AlgorithmStep> shellSortAndCalculateSteps({isAnalyzing = true}) {
    return _shellSort(isAnalyzing: true)!;
  }

  List<AlgorithmStep>? _shellSort({bool isAnalyzing = false}) {
    int n = length;
    final steps = isAnalyzing ? <AlgorithmStep>[] : null;

    // Start with a big gap, then reduce the gap
    for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
      // Do a gapped insertion sort for this gap size.
      // The first gap elements a[0..gap-1] are already
      // in gapped order keep adding one more element
      // until the entire array is gap sorted
      for (int i = gap; i < n; i += 1) {
        // add a[i] to the elements that have been gap
        // sorted save a[i] in temp and make a hole at
        // position i
        int temp = this[i];

        // shift earlier gap-sorted elements up until
        // the correct location for a[i] is found
        int j;
        final subSteps = isAnalyzing ? <AlgorithmSubStep>[] : null;
        for (j = i; j >= gap && this[j - gap] > temp; j -= gap) {
          subSteps?.add(
            AlgorithmSubStep(
              index: j,
              barType: 10,
              beforeChangeValue: this[j],
              newValue: this[j - gap],
            ),
          );
          this[j] = this[j - gap];
        }
        subSteps?.add(
          AlgorithmSubStep(
            index: j,
            barType: 10,
            beforeChangeValue: this[j],
            newValue: temp,
          ),
        );
        steps?.add(AlgorithmStep(subSteps: subSteps!));
        this[j] = temp;
      }
    }
    return steps;
  }
}
