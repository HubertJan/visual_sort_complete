import 'package:flutter/material.dart';

class AlgorithmListItem extends StatelessWidget {
  final String title;
  final String description;
  final Function onClick;
  final bool isSelected;

  const AlgorithmListItem(
      {Key? key,
      required this.title,
      required this.description,
      required this.onClick,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 96,
                child:
                    Text(title, style: Theme.of(context).textTheme.labelLarge)),
            SizedBox(width: 128, child: Text(description)),
            Checkbox(
                fillColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary),
                value: isSelected,
                onChanged: (_) {
                  onClick();
                })
          ],
        ),
      ),
    );
  }
}
