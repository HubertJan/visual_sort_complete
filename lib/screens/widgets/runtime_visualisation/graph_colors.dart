import 'package:flutter/material.dart';

final graphColors = [
  Colors.blue.shade500,
  Colors.red.shade500,
  Colors.yellow.shade700,
  Colors.purple.shade500,
  Colors.green.shade500,
  Colors.brown.shade500,
  Colors.lime.shade500,
];

extension ColorX on Color {
  String toHexTriplet() =>
      '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}
