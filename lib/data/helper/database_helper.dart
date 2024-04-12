import 'package:gplx/data/models/question_saved.dart';
import 'package:gplx/data/models/test.dart';
import 'package:gplx/data/models/test_details.dart';
import 'package:gplx/data/models/theogry_categories.dart';
import 'package:gplx/data/models/traffic_signs.dart';
import 'package:gplx/data/models/traffic_signs_categories.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show ByteData, rootBundle;

import '../models/question.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  static Database? _database;
  static final _dbName = 'db_gplx.db';

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);

    // Kiểm tra xem tệp cơ sở dữ liệu đã tồn tại trong thư mục documents chưa
    bool fileExists = await databaseExists(path);

    if (!fileExists) {
      // Nếu không, tải tệp từ thư mục assets
      ByteData data = await rootBundle.load('assets/data_assets/$_dbName');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }

    return await openDatabase(path);
  }

  Future<List<TheogryCategories>> getTheogryCategoryList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM TheogryCategory');

    return List.generate(
        maps.length, (index) => TheogryCategories.fromMap(maps[index]));
  }

  Future<List<Question>> getAllQuestions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
    await db.rawQuery('SELECT * FROM Questions');

    return List.generate(
        maps.length, (index) => Question.fromMap(maps[index]));
  }


  Future<Question?> getQuestionById(int idQuestion) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Questions',
      where: 'id = ?',
      whereArgs: [idQuestion],
    );

    if (maps.isEmpty) {
      return null;
    }

    final map = maps.first;
    return Question(
      map['id'] ?? 0,
      map['typeQuestion'] ?? 0,
      map['content'] ?? '',
      map['photo'] ?? '',
      (map['failingGradeQuestion'] ?? 0) == 1,
      map['option1'] ?? '',
      map['option2'] ?? '',
      map['option3'] ?? '',
      map['option4'] ?? '',
      map['correctOption'] ?? 0,
      map['answerExplanation'] ?? '',
      (map['isAnswered'] ?? 0) == 1,
    );
  }

  Future<List<Question>> getListQuestionByTypeQuestion(int typeQuestion) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM Questions WHERE typeQuestion = ?', [typeQuestion]);

    return List.generate(maps.length, (index) {
      final map = maps[index];
      return Question(
        map['id'] ?? 0,
        map['typeQuestion'] ?? 0,
        map['content'] ?? '',
        map['photo'] ?? '',
        (map['failingGradeQuestion'] ?? 0) == 1,
        map['option1'] ?? '',
        map['option2'] ?? '',
        map['option3'] ?? '',
        map['option4'] ?? '',
        map['correctOption'] ?? 0,
        map['answerExplanation'] ?? '',
        (map['isAnswered'] ?? 0) == 1,
      );
    });
  }

  Future<void> updateQuestionAnsweredStatus(int questionId) async {
    final db = await database;
    await db.update(
      'Questions',
      {'isAnswered': 1},
      where: 'id = ?',
      whereArgs: [questionId],
    );
  }

  Future<void> resetAllQuestionsAnsweredStatus() async {
    final db = await database;
    await db.update(
      'Questions',
      {'isAnswered': 0},
    );
  }

  Future<List<QuestionSaved>> getSavedQuestionsList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM QuestionsSaved');

    return List.generate(
        maps.length, (index) => QuestionSaved.fromMap(maps[index]));
  }
  //delete question saved
  Future<void> deleteQuestionSaved(int idQuestion) async {
    final db = await database;
    await db.delete(
      'QuestionsSaved',
      where: 'idQuestion = ?',
      whereArgs: [idQuestion],
    );
  }
  Future<void> addQuestionSaved(int idQuestion) async {
    // Kiểm tra xem câu hỏi đã tồn tại trong bảng QuestionsSaved hay chưa
    final db = await database;
    final existingQuestion = await db.query(
      'QuestionsSaved',
      where: 'idQuestion = ?',
      whereArgs: [idQuestion],
    );

    // Nếu câu hỏi không tồn tại, thêm nó vào bảng QuestionsSaved
    if (existingQuestion.isEmpty) {
      await db.insert(
        'QuestionsSaved',
        {'idQuestion': idQuestion},
      );
    }
  }
  Future<bool> checkExistQuestionSaved(int idQuestion) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'QuestionsSaved',
      where: 'idQuestion = ?',
      whereArgs: [idQuestion],
    );
    return result.isNotEmpty;
  }

  //Test
  Future<List<Test>> getTestsList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
    await db.rawQuery('SELECT * FROM Tests');

    return List.generate(
        maps.length, (index) => Test.fromMap(maps[index]));
  }


  Future<Test?> getTestById(int testId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Tests',
      where: 'id = ?',
      whereArgs: [testId],
    );

    if (maps.isEmpty) {
      return null;
    }

    final map = maps.first;
    return Test(
      map['id'] ?? 0,
      map['status'] ?? '',
      map['description'] ?? '',
      map['correctQuestionNumber'] ?? 0,
      map['wrongQuestionNumber'] ?? 0,
      map['fallingGradeQuestionNumber'] ?? 0,
      map['time'] ?? 0,
    );
  }




  //create new test with list question
  Future<void> createNewTest(List<Question> lstQuestions) async {
    final db = await database;

    // Bắt đầu một giao dịch để thêm test và các chi tiết của test
    await db.transaction((txn) async {
      // Thêm test mới vào bảng Tests
      int testId = await txn.insert(
        'Tests',
        {'status': 'BD',
          'description' : null,
          'correctQuestionNumber' : 0,
          'wrongQuestionNumber' : 0,
          'fallingGradeQuestionNumber' : 0,
          'time' : 1200
        },
      );

      // Thêm các chi tiết của test vào bảng TestDetails
      for (Question itemQuestion in lstQuestions) {
        await txn.insert(
          'TestDetails',
          {'idTest': testId,
            'idQuestion': itemQuestion.id,
            'optionChoosed' : 0
          },
        );
      }
    });
  }
  Future<void> updateTest(Test test) async {
    final db = await database;
    await db.update(
      'Tests',
      test.toMap(),
      where: 'id = ?',
      whereArgs: [test.id],
    );
  }


  Future<void> updateTestDetail(int idTest, int idQuestion, int choosedOption) async {
    final db = await database;
    await db.update(
      'TestDetails',
      {
        'idTest' : idTest,
        'idQuestion' : idQuestion,
        'optionChoosed' : choosedOption
      },
      where: 'idTest = ? AND idQuestion = ?',
      whereArgs: [idTest, idQuestion],
    );
  }


  Future<List<TestDetail>> getTestDetailsByTestId(int testID) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM TestDetails WHERE idTest = ?', [testID]);

    return List.generate(maps.length, (index) {
      return TestDetail.fromMap(maps[index]);
    });
  }

  Future<Test?> resetTestProgress(int testID) async {
    // final db = await database;

    Test? test = await getTestById(testID);

    if (test != null) {
      test.status = 'BD';
      test.correctQuestionNumber = 0;
      test.wrongQuestionNumber = 0;
      test.fallingGradeQuestionNumber = 0;
      test.time = 1200;
      await updateTest(test);


      List<TestDetail> testDetails = await getTestDetailsByTestId(testID);

      for (TestDetail detail in testDetails) {
        detail.optionChoosed = 0;
        await updateTestDetail(detail.idTest, detail.idQuestion, detail.optionChoosed);
      }
      return test;

    }
    return test;
  }

  Future<int> getCorrectQuestionNumberByTestId(int testID) async {
    final db = await database;

    // Truy vấn SQL để đếm số lượng câu hỏi có optionChoosed trùng với correctOption của câu hỏi
    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT COUNT(*) AS correctQuestionNumber
    FROM TestDetails AS td
    INNER JOIN Questions AS q ON td.idQuestion = q.id
    WHERE td.idTest = ? AND td.optionChoosed = q.correctOption
    ''', [testID]);

    // Lấy số lượng câu hỏi đúng từ kết quả truy vấn
    final int correctQuestionNumber = Sqflite.firstIntValue(result) ?? 0;

    return correctQuestionNumber;
  }

  Future<List<TrafficSignsCategories>> getTrafficSignsCategoryList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
    await db.rawQuery('SELECT * FROM TrafficSignsCategory');

    return List.generate(
        maps.length, (index) => TrafficSignsCategories.fromMap(maps[index]));
  }


  Future<List<TrafficSigns>> getListTrafficSignsByType(int type) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM TrafficSigns WHERE type = ?', [type]);

    return List.generate(maps.length, (index) {
      final map = maps[index];
      return TrafficSigns(
        map['id'] ?? 0,
        map['images'] ?? '',
        map['title'] ?? '',
        map['description'] ?? '',
        map['type'] ?? 0,
      );
    });
  }



}
