import 'package:flutter/material.dart';

class ChartsBar extends StatelessWidget {
  final String label;
  final double spendingAmt;
  final double spendingPctOfTtl;
  ChartsBar(this.label, this.spendingAmt, this.spendingPctOfTtl);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              //Used when you dont want the text to wrap but instead the text to shrink within the same space
              child: Text('\$${spendingAmt.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight *
                0.05, //used an alternative for margin/spacing
          ),
          Container(
            height: constraints.maxHeight * 0.6, //60% height of the parent
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTtl,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ), //Stack allows items to be placed over one another
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            child: FittedBox(//Fitted Box is used so that even if the device ends up being a very small one, the text will always be inside the box
              child: Text(label),
            ),
            height: constraints.maxHeight * 0.15,
          )
        ],
      ),
    );
  }
}
