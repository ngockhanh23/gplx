import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gplx/data/models/question.dart';

import '../../../services/asset_services.dart';

class QuestionReview extends StatelessWidget{
  final Question question ;
  final int optionChoosed ;
  QuestionReview({super.key, required this.question, required this.optionChoosed});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.content,
              style: const TextStyle(fontSize: 25),
            ),
            if(question.failingGradeQuestion)
              const Text(
                'Đây là câu điểm liệt',
                style: TextStyle(fontSize: 20, color: Colors.orange),
              ),
            if (question.photo.isNotEmpty)
              Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset(AssetServices.assetQuestionImagesPath +
                    question.photo),
              ),
            const SizedBox(
              height: 20,
            ),
            if (question.option1.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: (optionChoosed == 1 && optionChoosed != question.correctOption) ? Colors.red : ((question.correctOption == 1) ? Colors.green : Colors.transparent),
                  border: const Border(
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
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        const Text(
                          '1',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        question.option1,
                        maxLines: 8,
                        style: TextStyle(
                          fontSize: 20,
                          color: (optionChoosed == 1 && optionChoosed != question.correctOption) ? Colors.white : Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            if (question.option2.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: (optionChoosed == 2 && optionChoosed != question.correctOption) ? Colors.red : ((question.correctOption == 2) ? Colors.green : Colors.transparent),
                  border: const Border(
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
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        question.option2,
                        maxLines: 8,
                        style: TextStyle(
                          fontSize: 20,
                          color: (optionChoosed == 2 && optionChoosed != question.correctOption) ? Colors.white : Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            if (question.option3.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: (optionChoosed == 3 && optionChoosed != question.correctOption) ? Colors.red : ((question.correctOption == 3) ? Colors.green : Colors.transparent),

                  border: const Border(
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
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        const Text(
                          '3',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        question.option3,
                        maxLines: 8,
                        style: TextStyle(
                          fontSize: 20,
                          color: (optionChoosed == 3 && optionChoosed != question.correctOption) ? Colors.white : Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            if (question.option4.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: (optionChoosed == 4 && optionChoosed != question.correctOption) ? Colors.red : ((question.correctOption == 4) ? Colors.green : Colors.transparent),
                  border: const Border(
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
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        const Text(
                          '4',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        question.option4,
                        maxLines: 8,
                        style: TextStyle(
                          fontSize: 20,
                          color: (optionChoosed == 4 && optionChoosed != question.correctOption) ? Colors.white : Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

          ],
        ),
      ),
    );
  }
}