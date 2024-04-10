import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gplx/components/questions_list/question_doing_item.dart';
import 'package:gplx/data/models/test.dart';
import 'package:gplx/data/models/test_details.dart';
import 'package:gplx/screens/test_results/test_results.dart';
import 'package:gplx/services/color_services.dart';

import '../../data/helper/database_helper.dart';
import '../../data/models/question.dart';
import '../../services/enum/enum.dart';

class QuestionsListDoing extends StatefulWidget {
  List<Question> questionsData;
  DoingQuestionMode mode;
  int? timeDoingSeconds;
  int? testId;
  int? initialPageIndex;

  QuestionsListDoing(
      {super.key,
      required this.questionsData,
      required this.mode,
      this.timeDoingSeconds,
      this.testId,
      this.initialPageIndex});

  @override
  State<QuestionsListDoing> createState() => _QuestionsListDoingState();
}

class _QuestionsListDoingState extends State<QuestionsListDoing> {
  final List<Widget> pages = [];
  late PageController _pageController;
  int _currentPageIndex = 0;
  bool _isQuestionSaved = false;

  DateTime endTime = DateTime.now();
  int remainingSeconds = 0;

  int correctQuestion = 0;
  int wrongQuestion = 0;
  int fallingGradeQuestion = 0;

  List<int> lstOptionChoosed = [];

  @override
  void initState() {
    _currentPageIndex = widget.initialPageIndex ?? 0;

    _pageController = PageController(
        keepPage: true, initialPage: widget.initialPageIndex ?? 0);
    _getListQuestionWidgets();
    lstOptionChoosed = List<int>.filled(widget.questionsData.length, 0);

    super.initState();
  }

  _getListQuestionWidgets() {
    widget.questionsData.forEach((question) {
      pages.add(QuestionDoingItem(
        question: question,
        mode: widget.mode,
        handleChooseOption: handleChooseOptionQuestion,
      ));
    });
    _checkQuestionSaved(0);

    // Tính toán thời gian kết thúc gốc
    DateTime now = DateTime.now();
    int seconds = widget.timeDoingSeconds ?? 0;
    endTime = now.add(Duration(seconds: seconds));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _checkQuestionSaved(int index) async {
    bool isQuestionSaved = await DatabaseHelper()
        .checkExistQuestionSaved(widget.questionsData[index].id);
    setState(() {
      _isQuestionSaved = isQuestionSaved;
    });
  }

  _toggleQuestionSaved() {
    int currentQuestionId = widget.questionsData[_currentPageIndex].id;
    if (_isQuestionSaved) {
      DatabaseHelper().deleteQuestionSaved(currentQuestionId);
    } else {
      DatabaseHelper().addQuestionSaved(currentQuestionId);
    }
    setState(() {
      _isQuestionSaved = !_isQuestionSaved;
    });
  }

  handleChooseOptionQuestion(Question question, int optionChoosed) {
    if (widget.mode == DoingQuestionMode.doingTest) {
      lstOptionChoosed[_currentPageIndex] = optionChoosed;
    }
  }

  void _submitTest() {
    if (widget.mode == DoingQuestionMode.doingTest && widget.testId != null) {
      Test test = Test.empty();

      for (var i = 0; i < widget.questionsData.length; i++) {
        if (widget.questionsData[i].correctOption == lstOptionChoosed[i])
          correctQuestion++;
        else {
          if (widget.questionsData[i].failingGradeQuestion) {
            fallingGradeQuestion++;
          }
          wrongQuestion++;
        }

        DatabaseHelper().updateTestDetail(
            widget.testId!, widget.questionsData[i].id, lstOptionChoosed[i]);
      }

      test.id = widget.testId!;
      test.status = 'TTR';
      test.description = 'Sai câu điểm liệt';
      test.correctQuestionNumber = correctQuestion;
      test.wrongQuestionNumber = wrongQuestion;
      test.fallingGradeQuestionNumber = fallingGradeQuestion;
      DatabaseHelper().updateTest(test);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TestResults(
                    test: test,
                  )));
    }
  }

  _submitConfirm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có chắc chắn muốn nộp bài không?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
                _submitTest();
              },
              child: Text('Đồng ý'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: Text('Hủy bỏ'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.mode == DoingQuestionMode.doingTest &&
                widget.timeDoingSeconds != null)
            ? Row(
                children: [
                  const Text('Còn lại: '),
                  TimerCountdown(
                    format: CountDownTimerFormat.minutesSeconds,
                    enableDescriptions: false,
                    endTime: endTime,
                    onEnd: () => _submitTest(),
                    onTick: (duration) {
                      remainingSeconds = duration.inSeconds;
                      setState(() {});
                    },
                  ),
                ],
              )
            : Text(''),
        actions: [
          if (widget.mode == DoingQuestionMode.review)
            IconButton(
              onPressed: _toggleQuestionSaved,
              icon: Icon(
                Icons.favorite,
                size: 40,
                color: _isQuestionSaved ? Colors.red : null,
              ),
            )
          else
            TextButton(
                onPressed: () {
                  _submitConfirm();
                },
                child: const Text(
                  'Nộp bài',
                  style: TextStyle(fontSize: 20),
                ))
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  "Câu ${_currentPageIndex + 1}/${pages.length}",
                  style: const TextStyle(
                      fontSize: 18, color: CupertinoColors.inactiveGray),
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
                      _checkQuestionSaved(index);
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
                    child: Column(
                      children: [
                        _navigationPageBar(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: GridView.builder(
                            padding: const EdgeInsets.all(8),
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            '${index + 1}',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF007903),
              ),
              child: const Icon(
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
      decoration: const BoxDecoration(color: ColorServices.primaryColor),
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
            icon: const Icon(Icons.arrow_forward_ios),
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
