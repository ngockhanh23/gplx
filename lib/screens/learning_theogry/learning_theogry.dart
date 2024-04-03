import 'package:flutter/material.dart';
import 'package:gplx/screens/learning_theogry/theogry-item.dart';
import '../../data/helper/database_helper.dart';
import '../../data/models/theogry_categories.dart';

class LearningTheogry extends StatefulWidget {
  @override
  State<LearningTheogry> createState() => _LearningTheogryState();
}

class _LearningTheogryState extends State<LearningTheogry> {
  late Future<List<TheogryCategories>> _theogryCategoriesFuture;

  @override
  void initState() {
    super.initState();
    _theogryCategoriesFuture = _getTheogryCategoryList();
  }

  Future<List<TheogryCategories>> _getTheogryCategoryList() async {
    return DatabaseHelper().getTheogryCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Học lý thuyết"),
        actions: [
          IconButton(
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
            icon: Icon(Icons.delete_sweep_outlined, size: 35,),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<List<TheogryCategories>>(
          future: _theogryCategoriesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final theogryCategoriesList = snapshot.data!;
              return ListView.builder(
                itemCount: theogryCategoriesList.length,
                itemBuilder: (context, index) {
                  final item = theogryCategoriesList[index];
                  return TheogryItem(theogryCategories: item);
                },
              );
            }
          },
        ),
      ),
    );
  }
  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('Xóa tiến độ học lý thuyết'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Text('Bạn có chắc chắn muốn xóa tiến độ học lý thuyết không?', style:  TextStyle(fontSize: 20),),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Xác nhận'),
              onPressed: () {
                DatabaseHelper().resetAllQuestionsAnsweredStatus().then((_){
                  setState(() {

                  });
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
