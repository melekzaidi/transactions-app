import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/transaction.dart';
import 'package:flutter_application_1/widgets/chartbar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  late final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupetTransactionvalues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay).substring(0, 1));
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalspendingamount {
    return groupetTransactionvalues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(this.recentTransactions);
    if (this.recentTransactions.isEmpty) {
      return Card(
          elevation: 6,
          margin: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupetTransactionvalues.map((e) {
              return Flexible(
                  fit: FlexFit.tight,
                  child:
                      Chartbar(e['day'].toString(), e['amount'] as double, 0));
            }).toList(),
          ));
    } else {
      return Card(
          elevation: 6,
          margin: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupetTransactionvalues.map((e) {
              return Flexible(
                  fit: FlexFit.tight,
                  child: Chartbar(e['day'].toString(), e['amount'] as double,
                      (e['amount'] as double) / totalspendingamount as double));
            }).toList(),
          ));
    }
  }
}
