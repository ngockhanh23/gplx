import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gplx/data/helper/database_helper.dart';
import 'package:gplx/data/models/question.dart';
import 'package:gplx/data/models/traffic_signs.dart';
import 'package:gplx/screens/test_results/question_review/question_review.dart';

import '../../../services/asset_services.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Question> _lstQuestion = [];
  List<TrafficSigns> _lstTrafficSigns = [];
  List<Question> _lstQuestionShow = [];
  List<TrafficSigns> _lstTrafficSignsShow = [];

  TextEditingController _searchKeyController = TextEditingController();

  bool _filterByQuestions = true;
  bool _filterByTrafficSigns = true;

  void _onSearchTextChanged() {
    String searchText = _searchKeyController.text.toLowerCase();
    setState(() {
      _lstQuestionShow = _lstQuestion
          .where(
              (question) => question.content.toLowerCase().contains(searchText))
          .toList();
      _lstTrafficSignsShow = _lstTrafficSigns
          .where((trafficSign) =>
              trafficSign.title.toLowerCase().contains(searchText))
          .toList();
    });
  }

  Future<void> _fetchData() async {
    try {
      List<Question> questions = await DatabaseHelper().getListQuestions();
      List<TrafficSigns> lstTrafficSigns =
          await DatabaseHelper().getTrafficSignsList();
      _lstQuestion = questions;
      _lstTrafficSigns = lstTrafficSigns;
      setState(() {
        _lstQuestionShow = _lstQuestion;
        _lstTrafficSignsShow = _lstTrafficSigns;
      });
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error fetching : $e');
    }
  }

  @override
  void initState() {
    _fetchData();
    _searchKeyController.addListener(_onSearchTextChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tìm kiếm"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(
              controller: _searchKeyController,
              hintText: 'Tìm kiếm câu hỏi, biển báo giao thông',
              trailing: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                '${_lstTrafficSignsShow.length + _lstQuestionShow.length} Kết quả',
                style: const TextStyle(fontSize: 20, color: Colors.black54),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      ' Lọc theo:',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text('Câu hỏi'),
                        value: _filterByQuestions,
                        onChanged: (value) {
                          setState(() {
                            _filterByQuestions = value!;
                          });
                        }),
                  ),
                  Expanded(
                    flex: 4,
                    child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text('Biển báo'),
                        value: _filterByTrafficSigns,
                        onChanged: (value) {
                          setState(() {
                            _filterByTrafficSigns = value!;
                          });
                        }),
                  )
                ],
              ),
            ),

            // Padding(padding: const EdgeInsets.symmetric(vertical: 8),
            // child: ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (_filterByQuestions)
                      Column(
                        children: _lstQuestionShow
                            .map((question) => _questionResultItem(question))
                            .toList(),
                      ),
                    if (_filterByTrafficSigns)
                      Column(
                        children: _lstTrafficSignsShow
                            .map((trafficSign) =>
                                _trafficSignsResultItem(trafficSign))
                            .toList(),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _questionResultItem(Question question) {
    return Card(
      child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionReview(
                        question: question,
                        optionChoosed: question.correctOption)));
          },
          subtitleTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question.content,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              if (question.failingGradeQuestion)
                const Text(
                  'Câu điểm liệt',
                  style: TextStyle(color: Colors.orange),
                )
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (question.option1.isNotEmpty)
                Text('Câu 1: ${question.option1}'),
              if (question.option2.isNotEmpty)
                Text('Câu 2: ${question.option2}'),
              if (question.option3.isNotEmpty)
                Text('Câu 3: ${question.option3}'),
              if (question.option4.isNotEmpty)
                Text('Câu 4: ${question.option4}'),
              Row(
                children: [
                  const Text(
                    'Đáp án: ',
                    style: TextStyle(color: Colors.green),
                  ),
                  Text('Câu ${question.correctOption}')
                ],
              ),
            ],
          )),
    );
  }

  Widget _trafficSignsResultItem(TrafficSigns trafficSigns) {
    return Card(
        child: ListTile(
         title: Text(
        trafficSigns.title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
        subtitle: Text(trafficSigns.description),
        leading: Image.asset(
        AssetServices.assetTrafficSignsImagesPath + trafficSigns.images,
        width: 90,
        height: 90,
        fit: BoxFit.contain,
      ),
      onTap: () {
        // Handle tap on traffic sign tile
      },
    ));
  }
}
