import 'package:flutter/material.dart';
import '../../../data/helper/database_helper.dart';
import '../../../data/models/question_saved.dart';
import 'saved_question_item.dart';

class SavedQuestions extends StatefulWidget {
  @override
  _SavedQuestionsState createState() => _SavedQuestionsState();
}

class _SavedQuestionsState extends State<SavedQuestions> {
  late Future<List<QuestionSaved>> _questionsSavedList;

  @override
  void initState() {
    super.initState();
    _questionsSavedList = _getQuestionsSavedList();
  }

  Future<List<QuestionSaved>> _getQuestionsSavedList() async {
    return DatabaseHelper().getSavedQuestionsList();
  }


  _deleteSavedQuestion(int idQuestion) {
    DatabaseHelper().deleteQuestionSaved(idQuestion).then((_) {
      setState(() {
        _questionsSavedList = _getQuestionsSavedList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đã lưu"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _questionsSavedList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Đã xảy ra lỗi"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("Không có câu hỏi nào đã lưu"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return SavedQuestionItem(questionSaved: snapshot.data![index], deleteQuestion: _deleteSavedQuestion,);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
