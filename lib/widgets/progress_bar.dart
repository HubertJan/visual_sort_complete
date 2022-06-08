import 'package:flutter/material.dart';

class ProgresssBar extends StatelessWidget {
  final int maxValue;
  final int currentValue;

  const ProgresssBar({
    Key? key,
    required this.currentValue,
    required this.maxValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 64,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                  "${(currentValue / maxValue * 100).toStringAsFixed(2)}%"),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                heightFactor: 1,
                widthFactor: currentValue / maxValue,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
