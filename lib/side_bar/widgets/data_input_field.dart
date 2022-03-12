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
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            child: Text(
              text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ),
    );
  }
}
