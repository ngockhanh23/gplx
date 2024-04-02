import 'package:flutter/material.dart';
import 'package:gplx/services/asset_services.dart';
import 'package:gplx/services/color_services.dart';

class TheogryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Card(
        // elevation: 10,
        child: ListTile(
          onTap: (){},
          leading:
              Image.asset(AssetServices.assetTheogryIconPngPath + 'sa_hinh.png'),
          title: Text(
            "Khái niệm và quy tắc",
            style: TextStyle(fontSize: 22),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "gồm 83 câu hỏi",
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
                      child: const LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        valueColor:
                            AlwaysStoppedAnimation(ColorServices.primaryColor),
                        value: 60 / 80,
                      )),
                  const SizedBox(width: 10,),
                  Expanded(
                    // flex: 1,
                      child: Text("60/80"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
