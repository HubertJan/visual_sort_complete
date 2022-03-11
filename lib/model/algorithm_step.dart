class AlgorithmStep {
  final int from;
  final int to;
  final bool doesMove;

  List<int> doStep(final List<int> oldList) {
    final newList = List<int>.from(oldList);
    if (doesMove) {
      final cache = newList[from];
      newList[from] = newList[to];
      newList[to] = cache;
    }
    return newList;
  }

  List<int> undoStep(final List<int> oldList) {
    final newList = List<int>.from(oldList);
    if (doesMove) {
      final cache = newList[to];
      newList[to] = newList[from];
      newList[from] = cache;
    }
    return newList;
  }

  AlgorithmStep({required this.from, required this.to, required this.doesMove});
}
