import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPct;

  const ChartBar(this.label, this.spendingAmount, this.spendingPct);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          SizedBox(
              height: constraints.maxHeight * .15,
              child: FittedBox(
                  child: Text('P${spendingAmount.toStringAsFixed(2)}'))),
          const SizedBox(
            height: .05,
          ),
          SizedBox(
            height: constraints.maxHeight * .6,
            width: 10,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPct,
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10))),
              )
            ]),
          ),
          const SizedBox(
            height: .05,
          ),
          SizedBox(
            height: constraints.maxHeight * .15,
            child: FittedBox(child: Text(label)),
          )
        ],
      );
    });
  }
}
