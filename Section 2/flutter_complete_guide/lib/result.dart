import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int _totalScore;
  final Function _resetFunction;

  const Result(this._totalScore, this._resetFunction);

  String get subtext {
    if (_totalScore > 100) {
      return 'You\'re a out of this world!';
    } else if (_totalScore > 80) {
      return 'You\'re a genius!';
    } else if (_totalScore > 60) {
      return 'You\'re purty smart';
    } else if (_totalScore > 50) {
      return 'You\'re just plain dumb.';
    } else {
      return 'You\'re just plain EG-NO-RA-MOOSE.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'Wow you got ' + _totalScore.toString(),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text(
        subtext,
        style: TextStyle(fontSize: 16),
      ),
      IconButton(onPressed: _resetFunction, icon: Icon(Icons.replay_outlined))
    ]));
  }
}
