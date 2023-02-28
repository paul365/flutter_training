import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function addTransaction;

  TransactionForm(this.addTransaction);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final title = TextEditingController();
  final amount = TextEditingController();
  DateTime? _dateSelected;

  submit() {
    final titleValue = title.text;
    final amountValue = double.parse(amount.text);

    if (titleValue.isEmpty || amountValue <= 0) {
      return;
    }

    widget.addTransaction(Transaction(
        id: DateTime.now().toString(),
        title: titleValue,
        amount: amountValue,
        date: _dateSelected == null ? DateTime.now() : _dateSelected!));
    title.clear();
    amount.clear();
    Navigator.of(context).pop();
  }

  _openDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _dateSelected = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          child: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: title,
              onSubmitted: (_) => submit(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amount,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submit(),
            ),
            Row(
              children: [
                Text(_dateSelected == null
                    ? 'No date chosen!'
                    : DateFormat.yMd().format(_dateSelected!)),
                TextButton(
                    onPressed: _openDatePicker,
                    child: const Text(
                      'Select date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            ElevatedButton(
                onPressed: submit, child: const Text('Add transaction'))
          ],
        ),
      )),
    );
  }
}
