import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/algorithm_state.dart';

class SortVisualisation extends StatefulWidget {
  const SortVisualisation({Key? key}) : super(key: key);

  @override
  State<SortVisualisation> createState() => _SortVisualisationState();
}

class _SortVisualisationState extends State<SortVisualisation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlgorithmState>(
      builder: (ctx, state, _) {
        return Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  height: 300,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FractionallySizedBox(
                        heightFactor: 0.7,
                        child: Container(
                          width: 100,
                          color: Colors.blue,
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: 0.2,
                        child: Container(
                          width: 100,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 300,
                color: Colors.yellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${state.currentStepIndex}"),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: Text("Nächster"),
                          onPressed: () {
                            state.nextStep();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
