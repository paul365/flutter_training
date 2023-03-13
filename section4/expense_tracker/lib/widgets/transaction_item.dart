import 'dart:math';

import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem(
      {super.key,
      required Transaction transaction,
      required Function deleteTransaction})
      : _transaction = transaction,
        _deleteTransaction = deleteTransaction;

  final Transaction _transaction;
  final Function _deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.pink,
      Colors.orange
    ];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: Text('P${widget._transaction.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ),
        title: Text(
          widget._transaction.title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text(
          DateFormat(DateFormat.YEAR_MONTH_DAY)
              .format(widget._transaction.date),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => widget._deleteTransaction(widget._transaction.id),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      ),
      // Alternative implementation
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
  }
}
