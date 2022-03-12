import 'package:flutter/material.dart';

class RuntimeVisualisation extends StatelessWidget {
  const RuntimeVisualisation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54, //Theme.of(context).colorScheme.background,
      child: Center(
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RuntimeBar(
                  height: 0.2,
                ),
                RuntimeBar(
                  height: 0.2,
                ),
                RuntimeBar(
                  height: 0.5,
                ),
                RuntimeBar(
                  height: 0.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RuntimeBar extends StatelessWidget {
  final double height;

  const RuntimeBar({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: height,
              child: Container(
                height: 50,
                color: Colors.yellow,
              ),
            ),
          ),
          Text("Mergesort", style: Theme.of(context).textTheme.headline5),
        ],
      ),
    );
  }
}
