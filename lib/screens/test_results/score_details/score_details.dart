import 'package:flutter/material.dart';
import 'package:gplx/data/helper/database_helper.dart';
import 'package:gplx/data/models/test_details.dart';
import 'package:gplx/screens/test_results/question_review/question_review.dart';

import '../../../data/models/question.dart';

class ScoreDetails extends StatelessWidget {
  final int testID;

  ScoreDetails({Key? key, required this.testID}) : super(key: key);

  Future<List<TestDetail>> _getTestDetails() async {
    return DatabaseHelper().getTestDetailsByTestId(testID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TestDetail>>(
      future: _getTestDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<TestDetail>? testDetails = snapshot.data;
          if (testDetails != null && testDetails.isNotEmpty) {
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: testDetails.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ScoreDetailQuestionItem(
                  index: index,
                  idQuestion: testDetails[index].idQuestion,
                  optionChoosed: testDetails[index].optionChoosed,
                );
              },
            );
          } else {
            return Center(
              child: Text('No score details available.'),
            );
          }
        }
      },
    );
  }
}

class ScoreDetailQuestionItem extends StatelessWidget {
  final int index;
  final int idQuestion;
  final int optionChoosed;

  ScoreDetailQuestionItem(
      {super.key,
      required this.index,
      required this.idQuestion,
      required this.optionChoosed});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Question?>(
      future: DatabaseHelper().getQuestionById(idQuestion),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final question = snapshot.data;
            if (question == null) {
              return Text('Không có câu hỏi');
            } else {
              final bool isCorrectOption = question.correctOption == optionChoosed;
              final Color color = isCorrectOption ? Colors.green : Colors.redAccent;

              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionReview(question: question,optionChoosed: optionChoosed,)));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      '${index+1}',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    if (isCorrectOption)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF007903),
                          ),
                          child: Icon(
                            Icons.check ,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }
          }
        }
      },
    );
  }
}
