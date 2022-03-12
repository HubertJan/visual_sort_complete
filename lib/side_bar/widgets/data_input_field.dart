import 'package:flutter/material.dart';

class DateInputField extends StatelessWidget {
  final String text;
  const DateInputField({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        primary: false,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
