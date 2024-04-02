import 'package:flutter/material.dart';
import 'package:gplx/screens/main_screens/home/home.dart';
import 'package:gplx/screens/main_screens/mark_questions/mark_questions.dart';
import 'package:gplx/screens/main_screens/search/search.dart';

class MainScreens extends StatefulWidget{

  @override
  State<MainScreens> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreens> {
  int _indexFragment = 0;

  List<Widget> lstScreen  = [
    Home(),
    Search(),
    MarkQuestions()
  ];
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: IndexedStack(
        index: _indexFragment,
        children: lstScreen,
      ),


      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _indexFragment,
        onTap: (index){
          setState(() {
            _indexFragment = index;
            print(_indexFragment);

          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Trang chủ",

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Tìm kiếm"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              label: "Đã lưu"
          ),

        ],

      ),
    );

  }
}