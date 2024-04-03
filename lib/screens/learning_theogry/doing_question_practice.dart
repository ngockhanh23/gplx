import 'package:flutter/material.dart';
import 'package:gplx/components/questions_list/questions_list.dart';

import '../../data/models/question.dart';

class DoingQuestionPractice extends StatelessWidget{
  List<Question> lstQuestions ;
  DoingQuestionPractice({super.key, required this.lstQuestions});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: QuestionsList(questionsData: lstQuestions, showAnswer: true,),
    );
  }
}