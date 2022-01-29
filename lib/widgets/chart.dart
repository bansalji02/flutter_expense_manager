import 'package:expensemanager/model/transaction.dart';
import 'package:expensemanager/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      //here we are adding a weekday variable to show the day of the week in chart
      //we will take today's dateTime and the subtract the index from it to get the last day of the week
      //for example for index=0, we subtract 0 from today and we get today, for index 1, we subtract 1 from today and we get a day yesterday!

      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalAmount = 0;
      //for getting the dynamic output of total amount on that day
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      }; //using the .E method because it returns only the first letter of day
    }).reversed.toList();
  }

  //calculating the spending amount over the whole week
  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue +
          element[
              'amount']; //now this return value will be passed in the 2nd argument of fold method
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              child: Bar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.00
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
    );
  }
}
