import 'package:flutter/material.dart';

class Chartbar extends StatelessWidget {
  late final String label;
  late final double spendingamount;
  late final double spendingpctoftotal;
  Chartbar(this.label, this.spendingamount, this.spendingpctoftotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${spendingamount.toStringAsFixed(0)}'))),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: 1 - spendingpctoftotal,
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(height: constraints.maxHeight * 0.2, child: Text(label))
        ],
      );
    });
  }
}
