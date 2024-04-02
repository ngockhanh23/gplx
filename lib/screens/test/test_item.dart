import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gplx/screens/test_results/test_results.dart';
import 'package:gplx/services/color_services.dart';

class TestItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TestResults()));
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text("Đề số 1", style: TextStyle(fontSize: 20),),
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