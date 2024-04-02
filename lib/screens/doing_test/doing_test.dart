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
    Question(
      1,
      1,
      "Content 1",
      "photo1.jpg",
      false,
      "Option 1",
      "Option 2",
      "Option 3",
      "Option 4",
      1,
      "Explanation 1",
    ),
    Question(
      2,
      1,
      "Content 2",
      "photo2.jpg",
      true,
      "Option A",
      "Option B",
      "Option C",
      "Option D",
      2,
      "Explanation 2",
    ),
    Question(
      3,
      2,
      "Content 3",
      "photo3.jpg",
      false,
      "A",
      "B",
      "C",
      "D",
      3,
      "Explanation 3",
    ),
    Question(
      4,
      3,
      "Content 4",
      "photo4.jpg",
      true,
      "Answer 1",
      "Answer 2",
      "Answer 3",
      "Answer 4",
      4,
      "Explanation 4",
    ),
    Question(
      5,
      1,
      "Content 5",
      "photo5.jpg",
      false,
      "Choice 1",
      "Choice 2",
      "Choice 3",
      "",
      1,
      "Explanation 5",
    ),
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


