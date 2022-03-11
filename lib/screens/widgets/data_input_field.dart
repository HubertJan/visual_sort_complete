import 'package:flutter/material.dart';

class DateInputField extends StatelessWidget {
  final String text;
  const DateInputField({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Text(
          text,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
