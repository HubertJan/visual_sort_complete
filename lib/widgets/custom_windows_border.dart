import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class CustomWindowsBorder extends StatelessWidget {
  final Widget child;

  const CustomWindowsBorder({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
        color: Colors.black,
        width: 1,
        child: Column(
          children: [
            RightSide(),
            Expanded(
              child: child,
            )
          ],
        ));
  }
}

class RightSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.95),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        WindowTitleBarBox(
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            width: 16,
          ),
          Text(
            "Visual Sort Complete",
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Colors.grey,
                ),
          ),
          Expanded(child: MoveWindow()),
          WindowButtons()
        ])),
      ]),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: Colors.white,
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: Colors.white,
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
