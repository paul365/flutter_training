import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';
import 'package:flutter_complete_guide/question.dart';

class Quiz extends StatelessWidget {
  final Function answerQuestion;
  final List<Map<String, Object>> questions;
  final int questionIndex;

  const Quiz(
      {@required this.answerQuestion,
      @required this.questions,
      @required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Question(questions[questionIndex]['questionText']),
      ...(questions[questionIndex]['answersList'] as List<Map<String, Object>>)
          .map((ans) {
        return Answer(ans, answerQuestion);
      })
    ]);
  }
}
