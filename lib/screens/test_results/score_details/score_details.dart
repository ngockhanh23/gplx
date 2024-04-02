import 'package:flutter/material.dart';

class ScoreDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 24,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      physics: NeverScrollableScrollPhysics(), // Khóa cuộn
      itemBuilder: (BuildContext context, int index) {
        return _scoreDetailItem(index);
      },
    );
  }

  Widget _scoreDetailItem(int index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Hình tròn nền xanh
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
        // Số ở giữa
        Text(
          '${index+1}',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        // Biểu tượng dấu tick ở góc trên
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 24, // Kích thước của hình tròn
            height: 24, // Kích thước của hình tròn
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Hình dạng hình tròn
              color: Color(0xFF007903), // Màu nền của hình tròn
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 18, // Kích thước của biểu tượng dấu check
            ),
          ),
        ),

      ],
    );
  }
}
