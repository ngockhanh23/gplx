import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gplx/screens/doing_test/doing_test.dart';
import 'package:gplx/screens/test_results/score_details/score_details.dart';

import '../../services/color_services.dart';

class TestResults extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
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
                                  value: 8/25,
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
                                        '16%',
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
                      Text("Số câu trả lời đúng: 19/25", style: TextStyle(fontSize: 25),),
                      const SizedBox(height: 20,),
                      Text("TRƯỢT", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.redAccent),),
                      Text("(Sai câu điểm liệt)", style: TextStyle(fontSize: 20, color: Colors.grey),)
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
                                  Text("Thời gian làm bài:", style: TextStyle(fontSize: 20),),
                                ],
                              ),
                              const SizedBox( width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("19/25", style: TextStyle(fontSize: 20, color: ColorServices.primaryColor),),
                                  Text("30", style: TextStyle(fontSize: 20, color: ColorServices.primaryColor),),
                                  Text("2", style: TextStyle(fontSize: 20, color: ColorServices.primaryColor),),
                                  Text("20 phút", style: TextStyle(fontSize: 20, color: ColorServices.primaryColor),),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(thickness: 0.5,),
                        Container(height:300,child: ScoreDetails())
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DoingTest()));
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

