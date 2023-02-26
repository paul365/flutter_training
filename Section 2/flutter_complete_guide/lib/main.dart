import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';
import 'package:flutter_complete_guide/question.dart';
import 'package:flutter_complete_guide/quiz.dart';
import 'package:flutter_complete_guide/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;

  final questions = const [
    {
      'questionText': 'question 1',
      'answersList': [
        {'text': 'answer 1', 'score': 10},
        {'text': 'answer 2', 'score': 20},
        {'text': 'answer 3', 'score': 30},
        {'text': 'answer 4', 'score': 40},
      ]
    },
    {
      'questionText': 'question 2',
      'answersList': [
        {'text': 'answer 1', 'score': 10},
        {'text': 'answer 2', 'score': 20},
        {'text': 'answer 3', 'score': 30},
        {'text': 'answer 4', 'score': 40},
      ]
    },
    {
      'questionText': 'question 3',
      'answersList': [
        {'text': 'answer 1', 'score': 10},
        {'text': 'answer 2', 'score': 20},
        {'text': 'answer 3', 'score': 30},
        {'text': 'answer 4', 'score': 40},
      ]
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _questionIndex += 1;
      _totalScore += score;
    });
  }

  void _resetFunction() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(title: Text('Hello flutta')),
          body: _questionIndex < questions.length
              ? Quiz(
                  questionIndex: _questionIndex,
                  questions: questions,
                  answerQuestion: _answerQuestion)
              : Result(_totalScore, _resetFunction)),
    );
  }
}
