import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pysort_flutter/providers/sort_graph_state.dart';
import 'package:pysort_flutter/widgets/row_builder.dart';

class Bars extends StatelessWidget {
  const Bars({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<SortGraphState?>(builder: (ctx, state, _) {
        if (state == null) {
          return const SizedBox();
        }
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: RowBuilder(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            itemBuilder: (ctx, index) {
              final element = state.elementList[index];
              final status =
                  state.currentStep?.getBarStatusOf(index)?.toBarStatus() ??
                      BarStatus.none;
              return Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Bar(
                    height: element / (state.data.highestValue * 1.05),
                    status: status,
                  ),
                ),
              );
            },
            itemCount: state.elementList.length,
          ),
        );
      }),
    );
  }
}

enum BarStatus { none, selected, willBeMoved }

extension _BarStatusConverter on int {
  BarStatus toBarStatus() {
    switch (this) {
      case 11:
        return BarStatus.selected;
      case 10:
        return BarStatus.willBeMoved;
      default:
        return BarStatus.none;
    }
  }
}

class Bar extends StatelessWidget {
  final double height;
  final BarStatus status;

  const Bar({Key? key, required this.height, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color;
    switch (status) {
      case BarStatus.none:
        color = Colors.blue;
        break;
      case BarStatus.selected:
        color = Colors.yellow;
        break;
      case BarStatus.willBeMoved:
        color = Colors.pink;
        break;
    }
    return FractionallySizedBox(
      heightFactor: height,
      child: Container(
        color: color,
      ),
    );
  }
}
