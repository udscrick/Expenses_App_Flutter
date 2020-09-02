import 'package:flutter/material.dart';
import 'package:my_expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';
import './charts_bar.dart';

class Charts extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Charts(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(
          days: index)); //Will get 1 for yesterday, 2 for day before and so on
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {
        'day': DateFormat.E()
            .format(weekDay)
            .substring(0, 1), //Gives M for monday and so on
        'amount': totalSum
      };
    }).reversed.toList();//TO get the days of the week in a reverse order, so today is on extreme right
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0,
        (previousValue, element) =>
            previousValue + element['amount']); //Same as reduce in JS
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((e) {
              return Flexible(//FOr using the 'flex' property
                fit: FlexFit.tight,//Forces child to use all the available remaining space
                  child: ChartsBar(
                      e['day'],
                      e['amount'],
                      totalSpending == 0.0
                          ? 0.0
                          : (e['amount'] as double) / totalSpending));
            }).toList()),
      ),
    );
  }
}
