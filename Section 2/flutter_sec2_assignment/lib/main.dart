import 'package:flutter/material.dart';
import 'package:flutter_sec2_assignment/message.dart';
import 'package:flutter_sec2_assignment/text_control.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Section 2: assignment'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _message = 'Initial message';
  var _counter = 0;

  _changeText() {
    setState(() {
      _counter += 1;
      _message = 'Updated message. Couunter ' + _counter.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Message(_message), TextControl(_changeText)],
        ),
      ),
    );
  }
}
