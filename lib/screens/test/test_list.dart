import 'package:flutter/material.dart';
import 'package:gplx/screens/test/test_item.dart';

import '../../services/color_services.dart';

class TestList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thi sát hạch'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: 5, // Số lượng items, bao gồm cả item mới
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index == 4) {
              // Kiểm tra nếu là index cuối cùng
              return addTestWidget();
            } else {
              return TestItem();
            }
          },
        ),
      ),
    );
  }
  Widget addTestWidget(){
    return InkWell(
      child: Card(
        child: Center(
          child: Text(
            'TẠO ĐỀ \n NGẪU NHIÊN',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28,
                color: ColorServices.primaryColor
            ),
          ),
        ),
      ),
    );
  }
}

