import 'package:flutter/material.dart';

class SideBarTitleBar extends StatelessWidget {
  final String title;

  const SideBarTitleBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      alignment: Alignment.centerLeft,
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.left,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade800,
            width: 1,
          ),
        ),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: Offset.fromDirection(1),
            color: Colors.black87,
          )
        ],
      ),
    );
  }
}
