class AlgorithmStep {
  late final List<AlgorithmSubStep> subSteps;

  List<int> doStep(final List<int> oldList) {
    final newList = List<int>.from(oldList);
    for (final subStep in subSteps) {
      if (subStep.value != null) {
        newList[subStep.index] = subStep.value!;
      }
      if (subStep.valueByIndex != null) {
        newList[subStep.index] = oldList[subStep.valueByIndex!];
      }
    }
    return newList;
  }

  List<int> undoStep(final List<int> oldList) {
    final newList = List<int>.from(oldList);
    for (final subStep in subSteps.reversed) {
      if (subStep.initValue != null) {
        newList[subStep.index] = subStep.initValue!;
      }
      if (subStep.initValueByIndex != null) {
        newList[subStep.index] = oldList[subStep.initValueByIndex!];
      }
    }
    return newList;
  }

  AlgorithmStep({
    required this.subSteps,
  });

  AlgorithmStep.fromList(List<Map<String, int?>> dataList) {
    final List<AlgorithmSubStep> subSteps = [];
    for (final subStepData in dataList) {
      subSteps.add(AlgorithmSubStep.fromMap(subStepData));
    }
    this.subSteps = subSteps;
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

class AlgorithmSubStep {
  final int index;
  final int barType;
  final int? value;
  final int? valueByIndex;
  final int? initValue;
  final int? initValueByIndex;

  bool get hasValue {
    return value != null || valueByIndex != null;
  }

  AlgorithmSubStep(
      {required this.index,
      required this.barType,
      required this.value,
      required this.valueByIndex,
      required this.initValue,
      required this.initValueByIndex});

  AlgorithmSubStep.fromMap(Map<String, int?> dataMap)
      : index = dataMap["index"]!,
        barType = dataMap["barType"]!,
        value = dataMap["value"],
        valueByIndex = dataMap["valueByIndex"],
        initValue = dataMap["initValue"],
        initValueByIndex = dataMap["initValueByIndex"];
}
