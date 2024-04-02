import 'package:flutter/material.dart';
import '../../data/helper/database_helper.dart';
import '../../data/models/theogry_categories.dart';

class LearningTheogry extends StatefulWidget {
  @override
  State<LearningTheogry> createState() => _LearningTheogryState();
}

class _LearningTheogryState extends State<LearningTheogry> {
  late List<TheogryCategories> theogryCategoriesList = [];

  @override
  void initState() {
    super.initState();
    _getTheogryCategoryList();
  }

  void _getTheogryCategoryList() async {
    theogryCategoriesList = await DatabaseHelper().getTheogryCategoryList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Học lý thuyết"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete_sweep_outlined, size: 35,),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: theogryCategoriesList.length,
          itemBuilder: (context, index) {
            final item = theogryCategoriesList[index];
            return ListTile(
              title: Text(item.theogryName),
            );
          },
        ),
      ),
    );
  }
}
