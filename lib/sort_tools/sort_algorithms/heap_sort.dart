import 'package:pysort_flutter/model/algorithm_step.dart';

extension HeapSort on List<int> {
  void heapSort() {
    _heapSort(isAnalyzing: false);
  }

  List<AlgorithmStep> heapSortAndCalculateSteps() {
    return _heapSort(isAnalyzing: true)!;
  }

  List<AlgorithmStep>? _heapSort({
    bool isAnalyzing = false,
  }) {
    final steps = isAnalyzing ? <AlgorithmStep>[] : null;
    // first place 'a' in max-heap order
    final result = _heapify(isAnalyzing: isAnalyzing);
    steps?.addAll(result!);

    int end = length - 1;
    while (end > 0) {
      // swap the root (maximum value) of the heap with the
      // last element of the heap
      steps?.add(
          SwapAlgorithmStep(firstElementIndex: end, secondElementIndex: 0));
      int tmp = this[end];
      this[end] = this[0];
      this[0] = tmp;

      // put the heap back in max-heap order
      final result = _siftDown(0, end - 1, isAnalyzing: isAnalyzing);
      steps?.addAll(result!);
      // decrement the size of the heap so that the previous
      // max value will stay in its proper place
      end--;
    }
    return steps;
  }

  List<AlgorithmStep>? _heapify({
    bool isAnalyzing = false,
  }) {
    final steps = isAnalyzing ? <AlgorithmStep>[] : null;

    // start is assigned the index in 'a' of the last parent node
    int start = (length - 2) ~/ 2; // binary heap

    while (start >= 0) {
      // sift down the node at index 'start' to the proper place
      // such that all nodes below the 'start' index are in heap
      // order
      final result = _siftDown(start, length - 1, isAnalyzing: isAnalyzing);
      steps?.addAll(result!);
      start--;
    }
    return steps;
  }

  List<AlgorithmStep>? _siftDown(
    int start,
    int end, {
    bool isAnalyzing = false,
  }) {
    // end represents the limit of how far down the heap to shift
    int root = start;
    final steps = isAnalyzing ? <AlgorithmStep>[] : null;

    while ((root * 2 + 1) <= end) {
      // While the root has at least one child
      int child = root * 2 + 1; // root*2+1 points to the left child
      // if the child has a sibling and the child's value is less than its sibling's...
      if (child + 1 <= end && this[child] < this[child + 1]) {
        child = child + 1; // .. then point to the right child instead
      }

      if (this[root] < this[child]) {
        // out of max-heap order
        steps?.add(SwapAlgorithmStep(
            firstElementIndex: root, secondElementIndex: child));
        int tmp = this[root];
        this[root] = this[child];
        this[child] = tmp;
        root = child; // repeat to continue shifting down the child now
      } else {
        return steps;
      }
    }
    return steps;
  }

  List<AlgorithmStep> heapSortAndAnalyzation() {
    return _heapSort(isAnalyzing: true)!;
  }
}
