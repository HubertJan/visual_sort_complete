import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class CustomWindowsBorder extends StatelessWidget {
  final Widget child;

  const CustomWindowsBorder({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
        color: Colors.black54,
        width: 1,
        child: Column(
          children: [
            RightSide(),
            Expanded(
              child: Container(color: Colors.yellow, child: child),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        WindowTitleBarBox(
            child: Row(
                children: [Expanded(child: MoveWindow()), WindowButtons()])),
      ]),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: Colors.white,
    mouseOver: Color(0xFFF6A00C),
    mouseDown: Color(0xFF805306),
    iconMouseOver: Color(0xFF805306),
    iconMouseDown: Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: Color(0xFFD32F2F),
    mouseDown: Color(0xFFB71C1C),
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