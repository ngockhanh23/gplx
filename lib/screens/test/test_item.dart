import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gplx/components/questions_list/questions_list.dart';
import 'package:gplx/components/time_display/time_display.dart';
import 'package:gplx/data/helper/database_helper.dart';
import 'package:gplx/data/models/question.dart';
import 'package:gplx/screens/test_results/test_results.dart';
import 'package:gplx/services/color_services.dart';
import 'package:gplx/services/enum/enum.dart';

import '../../data/models/test.dart';
import '../../data/models/test_details.dart';

class TestItem extends StatefulWidget{
  final int indexTest;
  Test test;
  TestItem({super.key, required this.indexTest, required this.test});

  @override
  State<TestItem> createState() => _TestItemState();
}



class _TestItemState extends State<TestItem> {

  int _correctQuestionNumber = 0;

  _getTest() async{
    List<Question> lstQuestionTest = [];
    List<TestDetail> testDetails = await DatabaseHelper().getTestDetailsByTestId(widget.test.id);

    // Lặp qua từng chi tiết bài kiểm tra và lấy câu hỏi tương ứng từ cơ sở dữ liệu
    for (TestDetail testDetail in testDetails) {
      Question? question = await DatabaseHelper().getQuestionById(testDetail.idQuestion);

      if (question != null) {
        lstQuestionTest.add(question);
      }
    }


    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionsListDoing(
          questionsData: lstQuestionTest,
          mode: DoingQuestionMode.doingTest,
          timeDoingSeconds: widget.test.time,
          testId: widget.test.id,
          // initialPageIndex: 3,
        ),
      ),
    );

    // Sau khi màn hình mới đóng lại, cập nhật lại trạng thái của widget.test
    // Test? updatedTest = await DatabaseHelper().getTestById(widget.test.id);
    // if (updatedTest != null) {
    //   setState(() {
    //     widget.test = updatedTest;
    //     _getCorrectQuestionNumber();
    //   });
    // }
    _reloadTest();
  }

  _getCorrectQuestionNumber() async {
    int correctQuestionNumber = await DatabaseHelper().getCorrectQuestionNumberByTestId(widget.test.id);
    setState(() {
      _correctQuestionNumber = correctQuestionNumber;
    });
  }


  _reloadTest() async {
    Test? updatedTest = await DatabaseHelper().getTestById(widget.test.id);
    if (updatedTest != null) {
      setState(() {
        widget.test = updatedTest;
        _getCorrectQuestionNumber();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCorrectQuestionNumber();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: ()  {
        if(widget.test.status == 'TTR'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TestResults(test: widget.test))).then((_) => {
            _reloadTest()
          });
        }
        else{
          _getTest();
        }
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
                    value: _correctQuestionNumber/25,
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
                          '${_correctQuestionNumber}/25',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          widget.test.status,
                          style: TextStyle(
                              fontSize: 25,
                              color: ColorServices.primaryColor
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'còn: ',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                            TimeDisplay(seconds: widget.test.time)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text("Đề số ${widget.indexTest}", style: TextStyle(fontSize: 20),),
           if(widget.test.description.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.warning, color: Colors.orangeAccent,),
                Text(widget.test.description, style: TextStyle(fontSize: 16, color: Colors.orangeAccent),),
              ],
            ),

          ],
        ),
      ),
    );

  }
}