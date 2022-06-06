class AlgorithmStep {
  late final List<AlgorithmSubStep> _subSteps;

  List<AlgorithmSubStep> get subSteps {
    return [..._subSteps];
  }

  List<int> doStep(final List<int> oldList) {
    final newList = List<int>.from(oldList);
    for (final subStep in subSteps) {
      if (subStep.newValue != null) {
        newList[subStep.index] = subStep.newValue!;
      }
      if (subStep.newValueByIndex != null) {
        newList[subStep.index] = oldList[subStep.newValueByIndex!];
      }
    }
    return newList;
  }

  List<int> undoStep(final List<int> oldList) {
    final newList = List<int>.from(oldList);
    for (final subStep in subSteps.reversed) {
      if (subStep.beforeChangeValue != null) {
        newList[subStep.index] = subStep.beforeChangeValue!;
      }
      if (subStep.beforeChangeValueByIndex != null) {
        newList[subStep.index] = oldList[subStep.beforeChangeValueByIndex!];
      }
    }
    return newList;
  }

  AlgorithmStep({
    required List<AlgorithmSubStep> subSteps,
  }) : _subSteps = subSteps;

  AlgorithmStep.fromList(List<Map<String, int?>> dataList) {
    final List<AlgorithmSubStep> subSteps = [];
    for (final subStepData in dataList) {
      subSteps.add(AlgorithmSubStep.fromMap(subStepData));
    }
    _subSteps = subSteps;
  }

  int? getBarStatusOf(int index) {
    for (final subStep in subSteps) {
      if (subStep.index == index) {
        return subStep.barType;
      }
    }
    return null;
  }
}

class SwapAlgorithmStep extends AlgorithmStep {
  SwapAlgorithmStep(
      {required int firstElementIndex, required int secondElementIndex})
      : super(subSteps: [
          AlgorithmSubStep(
            index: firstElementIndex,
            barType: 10,
            newValueByIndex: secondElementIndex,
            beforeChangeValueByIndex: secondElementIndex,
          ),
          AlgorithmSubStep(
            index: secondElementIndex,
            barType: 11,
            newValueByIndex: firstElementIndex,
            beforeChangeValueByIndex: firstElementIndex,
          ),
        ]);
}

class AlgorithmSubStep {
  final int index;
  final int barType;
  final int? newValue;
  final int? newValueByIndex;
  final int? beforeChangeValue;
  final int? beforeChangeValueByIndex;

  bool get hasValue {
    return newValue != null || newValueByIndex != null;
  }

  AlgorithmSubStep(
      {required this.index,
      required this.barType,
      this.newValue,
      this.newValueByIndex,
      this.beforeChangeValue,
      this.beforeChangeValueByIndex});

  AlgorithmSubStep.fromMap(Map<String, int?> dataMap)
      : index = dataMap["index"]!,
        barType = dataMap["barType"]!,
        newValue = dataMap["value"],
        newValueByIndex = dataMap["valueByIndex"],
        beforeChangeValue = dataMap["initValue"],
        beforeChangeValueByIndex = dataMap["initValueByIndex"];
}
