import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gplx/data/helper/database_helper.dart';
import 'package:gplx/data/models/question.dart';
import 'package:gplx/screens/learning_theogry/doing_question_practice.dart';
import 'package:gplx/services/asset_services.dart';
import 'package:gplx/services/color_services.dart';

import '../../data/models/theogry_categories.dart';

class TheogryItem extends StatefulWidget {
  final TheogryCategories theogryCategories;

  TheogryItem({super.key, required this.theogryCategories});

  @override
  State<TheogryItem> createState() => _TheogryItemState();
}

class _TheogryItemState extends State<TheogryItem> {
  List<Question> _lstQuestions = [];

  int _answeredQuestionCount = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getlstQuestionByTheogry(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildListItem(context);
        } else {
          return  Container();
        }
      },
    );
  }



  Future<void> _getlstQuestionByTheogry() async {
    _lstQuestions = await DatabaseHelper().getListQuestionByTypeQuestion(widget.theogryCategories.id);
    _answeredQuestionCount = _lstQuestions.where((question) => question.isAnswered).length;
  }

  Widget _buildListItem(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DoingQuestionPractice(lstQuestions: _lstQuestions)),
            ).then((_) {
              setState(() {

              });
            });
          },
          leading: Image.asset(AssetServices.assetTheogryIconPngPath + widget.theogryCategories.photoName),
          title: Text(
            widget.theogryCategories.theogryName,
            style: TextStyle(fontSize: 22),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "gồm ${_lstQuestions.length} câu hỏi",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "(n câu điểm liệt)",
                    style: TextStyle(fontSize: 16, color: Colors.deepOrange),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation(ColorServices.primaryColor),
                      value: _lstQuestions.isNotEmpty ? _answeredQuestionCount / _lstQuestions.length : 0,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Text("${_answeredQuestionCount}/${_lstQuestions.length}"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


