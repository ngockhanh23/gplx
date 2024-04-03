import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gplx/data/helper/database_helper.dart';
import 'package:gplx/services/color_services.dart';
import '../../data/models/question.dart';
import '../../services/asset_services.dart';

class QuestionDoingItem extends StatefulWidget {
  Question question;
  int? choosedOption;
  bool showAnswer;

  QuestionDoingItem(
      {super.key,
      required this.question,
      this.choosedOption,
      required this.showAnswer});

  @override
  State<QuestionDoingItem> createState() => _QuestionDoingItemState();
}

class _QuestionDoingItemState extends State<QuestionDoingItem>
    with AutomaticKeepAliveClientMixin {
  int? _seletedOption;
  bool _showAnswerExplain = false;


  _handleChooseOption(){
    if(!widget.question.isAnswered){
      DatabaseHelper().updateQuestionAnsweredStatus(widget.question.id);
    }

   if(widget.showAnswer == true){
     if(_seletedOption! == widget.question.correctOption)
       _showAnswerExplain = true;
     else
       _showAnswerExplain = false;
   }

  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question.content,
            style: TextStyle(fontSize: 25),
          ),
          if (widget.question.photo.isNotEmpty)
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Image.asset(AssetServices.assetQuestionImagesPath +
                  widget.question.photo),
            ),
          const SizedBox(
            height: 20,
          ),
          if (widget.question.option1.isNotEmpty)
            InkWell(
              onTap: () {
                setState(() {
                  _seletedOption = 1;
                  _handleChooseOption();
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: (widget.showAnswer && _seletedOption ==1) ? (_seletedOption == widget.question.correctOption ? Colors.greenAccent : Colors.redAccent) : Colors.transparent,
                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.black12),
                    bottom: BorderSide(width: 0.5, color: Colors.black12),
                  ),
                ),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _seletedOption == 1 ? ColorServices.primaryColor : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        Text(
                          '1',
                          style: TextStyle(
                            fontSize: 20,
                            color: _seletedOption == 1 ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.question.option1,
                        maxLines: 8,
                        style: const TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          if (widget.question.option2.isNotEmpty)
            InkWell(
              onTap: () {
                setState(() {
                  _seletedOption = 2;
                  _handleChooseOption();
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: (widget.showAnswer && _seletedOption ==2) ? (_seletedOption == widget.question.correctOption ? Colors.greenAccent : Colors.redAccent) : Colors.transparent,

                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.black12),
                    bottom: BorderSide(width: 0.5, color: Colors.black12),
                  ),
                ),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _seletedOption == 2 ? ColorServices.primaryColor : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        Text(
                          '2',
                          style: TextStyle(
                            fontSize: 20,
                            color: _seletedOption == 2 ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.question.option2,
                        maxLines: 8,
                        style: const TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (widget.question.option3.isNotEmpty)
            InkWell(
              onTap: () {
                setState(() {
                  _seletedOption = 3;
                  _handleChooseOption();
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: (widget.showAnswer && _seletedOption ==3) ? (_seletedOption == widget.question.correctOption ? Colors.greenAccent : Colors.redAccent) : Colors.transparent,

                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.black12),
                    bottom: BorderSide(width: 0.5, color: Colors.black12),
                  ),
                ),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _seletedOption == 3 ? ColorServices.primaryColor : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        Text(
                          '3',
                          style: TextStyle(
                            fontSize: 20,
                            color: _seletedOption == 3 ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.question.option3,
                        maxLines: 8,
                        style: const TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (widget.question.option4.isNotEmpty)
            InkWell(
              onTap: () {
                setState(() {
                  _seletedOption = 4;
                  _handleChooseOption();
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: (widget.showAnswer && _seletedOption ==4) ? (_seletedOption == widget.question.correctOption ? Colors.greenAccent : Colors.redAccent) : Colors.transparent,

                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.black12),
                    bottom: BorderSide(width: 0.5, color: Colors.black12),
                  ),
                ),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _seletedOption == 4 ? ColorServices.primaryColor : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        Text(
                          '4',
                          style: TextStyle(
                            fontSize: 20,
                            color: _seletedOption == 4 ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.question.option4,
                        maxLines: 8,
                        style: const TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 30,),

          _showAnswerExplain ? Card(
            color: Colors.greenAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Giải thích: '+widget.question.answerExplanation, style: const TextStyle(fontSize: 20),),
            ),
          ) : Container()
        ],
      ),
    );
  }
}
