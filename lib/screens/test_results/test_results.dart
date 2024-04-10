import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gplx/data/helper/database_helper.dart';
import 'package:gplx/data/models/test.dart';
import 'package:gplx/screens/doing_test/doing_test.dart';
import 'package:gplx/screens/test_results/score_details/score_details.dart';

import '../../components/questions_list/questions_list.dart';
import '../../data/models/question.dart';
import '../../data/models/test_details.dart';
import '../../services/color_services.dart';
import '../../services/enum/enum.dart';

class TestResults extends StatelessWidget{
  final Test test;
  const TestResults({super.key, required this.test});


  _resetTestProgess(BuildContext context) async {
    await DatabaseHelper().resetTestProgress(test.id).then((test) async {
      List<Question> lstQuestionTest = [];

      // Lấy danh sách các chi tiết bài kiểm tra từ cơ sở dữ liệu
      List<TestDetail> testDetails = await DatabaseHelper().getTestDetailsByTestId(test!.id);

      // Lặp qua từng chi tiết bài kiểm tra và lấy câu hỏi tương ứng từ cơ sở dữ liệu
      for (TestDetail testDetail in testDetails) {
        Question? question = await DatabaseHelper().getQuestionById(testDetail.idQuestion);

        if (question != null) {
          lstQuestionTest.add(question);
        }
      }

      // Chuyển sang màn hình làm bài kiểm tra và truyền các tham số cần thiết
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionsListDoing(
            questionsData: lstQuestionTest,
            mode: DoingQuestionMode.doingTest,
            timeDoingSeconds: test.time,
            testId: test.id,
            // initialPageIndex: 3,
          ),
        ),
      );

      // Sau khi màn hình mới đóng lại, cập nhật lại trạng thái của bài kiểm tra
      // Test? updatedTest = await DatabaseHelper().getTestById(test.id);
      // if (updatedTest != null) {
      //   // Gọi setState() để cập nhật trạng thái của widget.test
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => TestResults(test: updatedTest),
      //     ),
      //   );
      // }
    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(

                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                padding: EdgeInsets.all(10),
                                child: CircularProgressIndicator(
                                  value: test.correctQuestionNumber/25,
                                  strokeWidth: 14,
                                  backgroundColor: Colors.black26,
                                  color: ColorServices.primaryColor,
                                ),
                              ),
                              // Thêm các item bên trong Stack
                              Positioned(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        '${(test.correctQuestionNumber / 25 * 100).toStringAsFixed(0)}%',
                                        style: TextStyle(
                                            fontSize: 40,
                                            color: ColorServices.primaryColor
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text("Số câu trả lời đúng: ${test.correctQuestionNumber}/25", style: TextStyle(fontSize: 25),),
                      const SizedBox(height: 20,),
                      Text(test.status, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.redAccent),),
                      Text("(${test.description})", style: TextStyle(fontSize: 20, color: Colors.grey),)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Chi tiết điểm số", style: TextStyle(fontSize: 25, color: Color(0xFF424242),),),
                        Padding(
                          padding: const EdgeInsets.only(left:  20),
                          child: Row(
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Số câu đúng:", style: TextStyle(fontSize: 20),),
                                  Text("Số câu sai:", style: TextStyle(fontSize: 20),),
                                  Text("Số câu điểm liệt sai:", style: TextStyle(fontSize: 20),),
                                  // Text("Thời gian làm bài:", style: TextStyle(fontSize: 20),),
                                ],
                              ),
                              const SizedBox( width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${test.correctQuestionNumber}/25', style: TextStyle(fontSize: 20, color: ColorServices.primaryColor),),
                                  Text('${test.wrongQuestionNumber}', style: TextStyle(fontSize: 20, color: ColorServices.primaryColor),),
                                  Text('${test.fallingGradeQuestionNumber}', style: TextStyle(fontSize: 20, color: ColorServices.primaryColor),),
                                  // Text("20 phút", style: TextStyle(fontSize: 20, color: ColorServices.primaryColor),),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(thickness: 0.5,),
                        SizedBox(height:500,child: ScoreDetails(testID: test.id,))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),

      ),
      bottomNavigationBar: BottomAppBar(
        // color: Service.textColorOnBlack,
        // shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorServices.primaryColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(child: const Text("Quay lại")),
                  ),
                )),
            const SizedBox(width: 10,),
            Expanded(
                flex: 4,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DoingTest()));
                    _resetTestProgess(context);
                  },
                  child: Text(
                    "Làm lại",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(ColorServices.primaryColor),
                  ),
                )),

          ],
        ),
      ),
    );
  }
}

