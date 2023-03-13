import 'dart:ffi';
import 'dart:io';

import 'package:expense_tracker/widgets/adaptive_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/transaction_form.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';

void main() {
  // for forcing portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // end for forcing portrait mode
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Quicksand',
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      home: const MyHomePage(title: 'My expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(id: '1', amount: 80, title: 'Pepsi', date: DateTime.now()),
    // Transaction(id: '2', amount: 100, title: 'coke', date: DateTime.now()),
    // Transaction(
    //     id: '3', amount: 90, title: 'mountain dew', date: DateTime.now()),
  ];

  _addTransaction(Transaction newTransaction) {
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  _deleteTransaction(String transactionId) {
    setState(() {
      _transactions.removeWhere((element) => element.id == transactionId);
    });
  }

  _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: TransactionForm(_addTransaction),
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((tx) =>
            tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isIOS = Platform.isIOS;

    final headerButton = AdaptiveIconButton(
        _startAddNewTransaction, Icons.add, CupertinoIcons.add);

    final PreferredSizeWidget appBar = (isIOS
        ? CupertinoNavigationBar(
            middle: Text(widget.title),
            trailing:
                Row(mainAxisSize: MainAxisSize.min, children: [headerButton]),
          )
        : AppBar(
            title: Text(widget.title),
            actions: [headerButton],
          )) as PreferredSizeWidget;

    Widget noTransaction() {
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'No transactions yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ))
          ],
        ),
      );
    }

    Widget cuppertinoLayout(body) {
      return CupertinoPageScaffold(
        navigationBar: (appBar as ObstructingPreferredSizeWidget),
        child: body,
      );
    }

    Widget materialLayout(body) {
      return Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: const Icon(Icons.add),
        ),
      );
    }

    final body = SafeArea(
        child: _transactions.isEmpty
            ? noTransaction()
            : Column(children: [
                SizedBox(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        .2,
                    child: Chart(_recentTransactions)),
                SizedBox(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        .75,
                    child: TransactionList(_transactions, _deleteTransaction))
              ]));

    return isIOS ? cuppertinoLayout(body) : materialLayout(body);
  }
}
