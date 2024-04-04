import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gplx/data/helper/database_helper.dart';
import 'package:gplx/data/models/question.dart';
import 'package:gplx/data/models/question_saved.dart';

class SavedQuestionItem extends StatefulWidget {
  final QuestionSaved questionSaved;
  final Function deleteQuestion;

  SavedQuestionItem({super.key, required this.questionSaved, required this.deleteQuestion});

  @override
  _SavedQuestionItemState createState() => _SavedQuestionItemState();
}

class _SavedQuestionItemState extends State<SavedQuestionItem> {
  Question? _question;

  @override
  void initState() {
    super.initState();
    _getQuestion();
  }

  Future<void> _getQuestion() async {
    final question = await DatabaseHelper().getQuestionById(widget.questionSaved.idQuestion);
    setState(() {
      _question = question ?? Question.empty() ;
    });
  }


  @override
  Widget build(BuildContext context) {
    return _question == null ? Container() : Container(
      child: Stack(
        children: [
          Card(
            child: ListTile(
              title: Text(_question!.content ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(_question!.option1.isNotEmpty)
                    Text('1. '+_question!.option1),
                  if(_question!.option2.isNotEmpty)
                    Text('2. '+_question!.option2),
                  if(_question!.option3.isNotEmpty)
                    Text('3. '+_question!.option3),
                  if(_question!.option4.isNotEmpty)
                    Text('4. '+_question!.option4),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () => widget.deleteQuestion(widget.questionSaved.idQuestion),
              icon: Icon(Icons.favorite, size: 35, color: Colors.redAccent),
            ),
          )
        ],
      ),
    );
  }


}

