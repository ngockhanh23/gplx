import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gplx/data/helper/database_helper.dart';
import 'package:gplx/data/models/question.dart';
import 'package:gplx/screens/test/test_item.dart';
import 'package:gplx/services/data_services/question_services.dart';
import 'package:gplx/services/data_services/test_services.dart';

import '../../data/models/test.dart';
import '../../services/color_services.dart';

class TestList extends StatefulWidget {
  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {

  List<Test> _lstTests = [];

  @override
  void initState() {
    _getTestsList();
    super.initState();
  }

  _getTestsList() {
    DatabaseHelper().getTestsList().then((tests) {
      setState(() {
        _lstTests = tests;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thi sát hạch'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: _lstTests.length+1, // Số lượng items, bao gồm cả item mới
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index == _lstTests.length) {
              return addTestWidget();
            } else {
              return TestItem(indexTest: index+1, test: _lstTests[index],);
            }
          },
        ),
      ),
    );
  }



  Widget addTestWidget(){
    return InkWell(
      onTap: () {
        TestServices().createNewRandomTest().then((_) => {
              setState(() {
                _getTestsList();
              })
            });
      },
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

