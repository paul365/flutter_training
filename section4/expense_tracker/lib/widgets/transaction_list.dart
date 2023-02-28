import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  const TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            elevation: 6,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text(
                        'P${_transactions[index].amount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
              title: Text(
                _transactions[index].title,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              subtitle: Text(
                DateFormat(DateFormat.YEAR_MONTH_DAY)
                    .format(_transactions[index].date),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteTransaction(_transactions[index].id),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            ),
            // child: Row(children: [
            //   Container(
            //     margin:
            //         const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         color: Theme.of(context).primaryColor,
            //         width: 2,
            //       ),
            //     ),
            //     padding: const EdgeInsets.all(10),
            //     child: Padding(
            //       padding: EdgeInsets.all(5),
            //       child: FittedBox(
            //         child: Text(
            //           'P${_transactions[index].amount.toStringAsFixed(2)}',
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color: Theme.of(context).primaryColor),
            //         ),
            //       ),
            //     ),
            //   ),
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         _transactions[index].title,
            //         style: const TextStyle(
            //             fontWeight: FontWeight.w600, fontSize: 16),
            //       ),
            //       Text(
            //         DateFormat(DateFormat.YEAR_MONTH_DAY)
            //             .format(_transactions[index].date),
            //         style: const TextStyle(color: Colors.grey),
            //       ),
            //     ],
            //   )
            // ]),
          );
        },
        itemCount: _transactions.length,
      ),
    );
  }
}
