import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gplx/components/questions_list/questions_list.dart';

import '../../data/models/question.dart';

class DoingTest extends StatefulWidget {
  @override
  State<DoingTest> createState() => _DoingTestState();
}

class _DoingTestState extends State<DoingTest> {


  List<Question> questionData = [

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doing Test"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Nộp bài",
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
      body: Center(child: QuestionsList( questionsData: questionData, showAnswer: false,)),
      // bottomNavigationBar: _navigationPageBar(),
    );
  }


}


