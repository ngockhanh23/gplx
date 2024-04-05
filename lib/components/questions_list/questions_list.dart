import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gplx/components/questions_list/question_doing_item.dart';
import 'package:gplx/services/color_services.dart';

import '../../data/helper/database_helper.dart';
import '../../data/models/question.dart';
import '../../services/enum/enum.dart';

class QuestionsListDoing extends StatefulWidget {
  List<Question> questionsData;
  DoingQuestionMode mode;
  int? timeDoingSeconds;

  QuestionsListDoing({
    super.key,
    required this.questionsData,
    required this.mode,
    this.timeDoingSeconds
  });

  @override
  State<QuestionsListDoing> createState() => _QuestionsListDoingState();
}

class _QuestionsListDoingState extends State<QuestionsListDoing> {
  final List<Widget> pages = [];
  late PageController _pageController;
  int _currentPageIndex = 0;
  bool _isQuestionSaved = false;

  @override
  void initState() {
    _pageController = PageController(keepPage: true);
    _getListQuestionWidgets();
    super.initState();
  }

  _getListQuestionWidgets() {
    widget.questionsData.forEach((question) {
      pages.add(QuestionDoingItem(question: question, mode: widget.mode,));
    });
    _checkQuestionSaved(0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _checkQuestionSaved(int index) async {
    bool isQuestionSaved = await DatabaseHelper().checkExistQuestionSaved(widget.questionsData[index].id);
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
  void handleTimerFinished() {

    print('Thời gian kết thúc');
  }

  @override
  Widget build(BuildContext context) {
    DateTime endTime = DateTime.now();
    DateTime now = DateTime.now();
    int seconds = widget.timeDoingSeconds ?? 0;
    endTime = now.add(Duration(seconds: seconds));

    return Scaffold(
      appBar: AppBar(
        title: (widget.mode == DoingQuestionMode.doingTest  && widget.timeDoingSeconds != null) ? Row(
          children: [
            Text('Còn lại: '),
            TimerCountdown(
              format: CountDownTimerFormat.minutesSeconds,
              enableDescriptions: false,
              endTime: endTime,
              onEnd: () {
                print(seconds);
                print("Timer finished");
              },
              onTick: (duration) {
                int remainingSeconds = duration.inSeconds;
                print("Remaining seconds: $remainingSeconds");
              },
            ),
          ],
        ) : Text(''),

        // centerTitle: true,
        actions: [
          if(widget.mode == DoingQuestionMode.review)
            IconButton(
              onPressed: _toggleQuestionSaved,
              icon: Icon(
                Icons.favorite,
                size: 40,
                color: _isQuestionSaved ? Colors.red : null,
              ),
            )
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
                            padding: EdgeInsets.all(8),
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            '${index + 1}',
            style: TextStyle(
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









