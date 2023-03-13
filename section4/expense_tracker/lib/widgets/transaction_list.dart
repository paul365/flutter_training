import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  const TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          ..._transactions.map((elem) => TransactionItem(
              key: ValueKey(elem.id),
              transaction: elem,
              deleteTransaction: _deleteTransaction))
        ],
      ),
      // TODO: Note paul: avoid this, does not work with keys/has a bug
      // child: ListView.builder(
      //   itemBuilder: (ctx, index) {
      //     return TransactionItem(
      //       key: ValueKey(_transactions[index].id),
      //       transactions: _transactions,
      //       deleteTransaction: _deleteTransaction,
      //       index: index,
      //     );
      //   },
      //   itemCount: _transactions.length,
      // ),
    );
  }
}
