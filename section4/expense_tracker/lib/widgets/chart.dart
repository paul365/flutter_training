import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartData {
  final String day;
  final double amount;

  ChartData(this.day, this.amount);
}

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<ChartData> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }

      return ChartData(
          DateFormat.E().format(weekDay).substring(0, 1), totalAmount);
    }).reversed.toList();
  }

  double get maxSpending => groupedTransactions.fold(
      0.0, (previousValue, element) => previousValue += element.amount);

  const Chart(this.recentTransactions);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactions.map((e) {
                return Expanded(
                  child: ChartBar(e.day, e.amount,
                      maxSpending == 0.0 ? 0.0 : e.amount / maxSpending),
                );
              }).toList()),
        ));
  }
}
