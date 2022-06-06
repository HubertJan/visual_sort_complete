import 'dart:math';
import 'package:uuid/uuid.dart';

class DataSet {
  late final int highestValue;
  late final List<int> _data;
  late final String id;

  String asString() {
    return _data.map((i) => i.toString()).join(",");
  }

  List<int> get data {
    return [..._data];
  }

  DataSet(List<int> data)
      : _data = data,
        highestValue = data.reduce(max),
        id = const Uuid().v4();

  DataSet.generate({
    required int amount,
    required int lowestValue,
    required int highestValue,
    bool onlyUniqueNumbers = false,
  }) {
    if (onlyUniqueNumbers && highestValue - lowestValue + 1 < amount) {
      throw Exception("Value range has to be bigger than amount.");
    }
    if (highestValue <= lowestValue) {
      throw Exception(
          'lowest_value has to be lower than highest_value: $lowestValue not < $highestValue');
    }

    final possibleValues = List.generate(
        highestValue - lowestValue, (index) => index + lowestValue);

    _data = [];
    for (var i = 1; i < amount + 1; i++) {
      final index = Random().nextInt(possibleValues.length);
      final value = possibleValues[index];
      if (onlyUniqueNumbers) {
        possibleValues.removeAt(index);
      }
      _data.add(value);
    }

    this.highestValue = _data.reduce(max);
    id = const Uuid().v4();
  }
}

extension GenerateDataSets on List<DataSet> {
  void addGeneratedDataSets({
    required int lowestValue,
    required int highestValue,
    required int initialAmount,
    required int maxAmount,
    required int amountIncreasePerDataSet,
    required bool onlyUniqueNumbers,
  }) {
    if (amountIncreasePerDataSet <= 0) {
      throw ArgumentError("amountIncreasePerDataSet has to be bigger than 0.");
    }

    for (int amount = initialAmount;
        amount <= maxAmount;
        amount += amountIncreasePerDataSet) {
      add(DataSet.generate(
        amount: amount,
        lowestValue: lowestValue,
        highestValue: highestValue,
        onlyUniqueNumbers: onlyUniqueNumbers,
      ));
    }
  }
}
