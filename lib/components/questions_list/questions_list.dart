import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:gplx/components/questions_list/question_doing_item.dart';
import 'package:gplx/services/color_services.dart';

import '../../data/models/question.dart';

class QuestionsList extends StatefulWidget {
  List<Question> questionsData;
  bool showAnswer;

  QuestionsList({
    super.key,
    required this.questionsData,
    required this.showAnswer,
  });

  @override
  State<QuestionsList> createState() => _QuestionsListState();
}

class _QuestionsListState extends State<QuestionsList> {
  final List<Widget> pages = [];


  @override
  void initState() {
    _getListQuestionWidgets();
    super.initState();
  }

  _getListQuestionWidgets() {
    widget.questionsData.forEach((question) {
      pages.add(QuestionDoingItem(question: question));
    });
  }

  // Index của trang hiện tại
  int _currentPageIndex = 0;
  final PageController _pageController = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  "Câu ${_currentPageIndex + 1}/${pages.length}",
                  style: TextStyle(fontSize: 18, color: CupertinoColors.inactiveGray),
                ),
              ),
              Flexible(
                flex: 5,
                child: PageView(
                  children: pages,
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                ),
              ),
            ],
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 1,
            snap: true,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                color: Colors.white,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    // Sử dụng ScrollController này cho SingleChildScrollView
                    // padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        _navigationPageBar(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: GridView.builder(
                            padding: EdgeInsets.all(8),
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            controller: ScrollController(),
                            itemCount: pages.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _questionItemShow(index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      // bottomNavigationBar: _navigationPageBar(),
    );
  }

  Widget _questionItemShow(int index) {
    return InkWell(
      onTap: () {
        _pageController.jumpToPage(index);
      },
      child: Stack(
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
            '${index + 1}',
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
                shape: BoxShape.circle,
                color: Color(0xFF007903),
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navigationPageBar() {
    return Container(
      height: 100,
      decoration: BoxDecoration(color: ColorServices.primaryColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              _pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
          InkWell(onTap: () {}, child: Text('Câu ${_currentPageIndex + 1}')),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
        ],
      ),
    );
  }
}








