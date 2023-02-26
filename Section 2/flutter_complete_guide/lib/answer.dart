import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Map<String, Object> _answer;
  final Function _onPressed;

  const Answer(this._answer, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 8, right: 8),
      child: ElevatedButton(
        onPressed: () => _onPressed(_answer['score']),
        child: Text(_answer['text']),
      ),
    );
  }
}
