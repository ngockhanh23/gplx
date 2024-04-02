import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gplx/services/color_services.dart';
import '../../data/models/question.dart';
import '../../services/asset_services.dart';

class QuestionDoingItem extends StatefulWidget{
  Question question;
  int? choosedOption;

  QuestionDoingItem({super.key,required this.question, this.choosedOption});

  @override
  State<QuestionDoingItem> createState() => _QuestionDoingItemState();
}

class _QuestionDoingItemState extends State<QuestionDoingItem> with AutomaticKeepAliveClientMixin{

  int? _seletedOption;

  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {


    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            widget.question.content,
            style: TextStyle(fontSize: 25),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.asset(AssetServices.assetIconPngPath + 'bien_bao.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          if (widget.question.option1.isNotEmpty)
            InkWell(
              onTap: (){
                setState(() {
                  _seletedOption = 1;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(

                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.black12),
                    // border cho top
                    bottom: BorderSide(
                        width: 0.5, color: Colors.black12), // border cho bottom
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
                              border: Border.all(color: Colors.grey)),
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
                    Text(
                      widget.question.option1,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          if (widget.question.option2.isNotEmpty)
            InkWell(
              onTap: (){
                setState(() {
                  _seletedOption = 2;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(

                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.black12),
                    // border cho top
                    bottom: BorderSide(
                        width: 0.5, color: Colors.black12), // border cho bottom
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
                              border: Border.all(color: Colors.grey)),
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
                    Text(
                      widget.question.option2,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          if (widget.question.option3.isNotEmpty)
            InkWell(
              onTap: (){
                setState(() {
                  _seletedOption = 3;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(

                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.black12),
                    // border cho top
                    bottom: BorderSide(
                        width: 0.5, color: Colors.black12), // border cho bottom
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
                              border: Border.all(color: Colors.grey)),
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
                    Text(
                      widget.question.option3,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          if (widget.question.option4.isNotEmpty)
            InkWell(
              onTap: (){
                setState(() {
                  _seletedOption = 4;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(

                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.black12),
                    // border cho top
                    bottom: BorderSide(
                        width: 0.5, color: Colors.black12), // border cho bottom
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
                              border: Border.all(color: Colors.grey)),
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
                    Text(
                      widget.question.option4,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}