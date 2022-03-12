class AlgorithmStep {
  final int firstIndex;
  final int secondIndex;

  List<int> doStep(final List<int> oldList) {
    final newList = List<int>.from(oldList);
    if (true) {
      final cache = newList[firstIndex];
      newList[firstIndex] = newList[secondIndex];
      newList[secondIndex] = cache;
    }
    return newList;
  }

  List<int> undoStep(final List<int> oldList) {
    final newList = List<int>.from(oldList);
    if (true) {
      final cache = newList[secondIndex];
      newList[secondIndex] = newList[firstIndex];
      newList[firstIndex] = cache;
    }
    return newList;
  }

  AlgorithmStep({
    required this.firstIndex,
    required this.secondIndex,
  });

  AlgorithmStep.fromMap(Map<String, int> dataMap)
      : firstIndex = dataMap["firstIndex"]!,
        secondIndex = dataMap["secondIndex"]!;
}
