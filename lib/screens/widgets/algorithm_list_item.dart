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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(title),
          Text(description),
          ElevatedButton(
            child: Text(isSelected ? "Hinzufügen" : "Entfernen"),
            onPressed: () => onClick(),
          )
        ],
      ),
    );
  }
}
