import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;

  const Message(this.message);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(fontSize: 20),
    );
  }
}
