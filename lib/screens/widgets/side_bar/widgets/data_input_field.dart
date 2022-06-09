import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      height: 400,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              primary: false,
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 58,
                child: ElevatedButton(
                  child: const Icon(
                    Icons.copy,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith((state) {
                    if (state.contains(MaterialState.hovered)) {
                      return Theme.of(context).colorScheme.primary;
                    }
                    return Colors.black.withOpacity(0.9);
                  })),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: text));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
