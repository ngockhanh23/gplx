import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gplx/components/questions_list/questions_list.dart';
import 'package:gplx/data/helper/database_helper.dart';
import 'package:gplx/screens/test_results/test_results.dart';
import 'package:gplx/services/color_services.dart';
import 'package:gplx/services/enum/enum.dart';

import '../../data/models/test.dart';

class TestItem extends StatelessWidget{
  final int indexTest;
  final Test test;
  TestItem({super.key, required this.indexTest, required this.test});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: (){
        DatabaseHelper().getTestDetailsByTestId(test.id).then((testDetail) => {
          testDetail.forEach((element) {print(element.idQuestion);})
        });
        // Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionsListDoing(questionsData: [], mode: DoingQuestionMode.doingTest,timeDoingSeconds: 90,)));
      },
      child: Card(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                    value: 0/25,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey,
                    color: ColorServices.primaryColor,
                  ),
                ),
                // Thêm các item bên trong Stack
                Positioned(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          '0/25',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          'LÀM BÀI',
                          style: TextStyle(
                              fontSize: 25,
                              color: ColorServices.primaryColor
                          ),
                        ),
                        Text(
                          'còn: 20:00',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text("Đề số ${indexTest}", style: TextStyle(fontSize: 20),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.warning, color: Colors.orangeAccent,),
                Text("Sai câu điểm liệt", style: TextStyle(fontSize: 16, color: Colors.orangeAccent),),
              ],
            ),

          ],
        ),
      ),
    );

  }
}