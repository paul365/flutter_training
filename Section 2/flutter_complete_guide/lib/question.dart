import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String _questionText;

  const Question(this._questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
        child: Text(
          _questionText,
          style: TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ));
  }
}
