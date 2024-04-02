import 'package:gplx/data/models/theogry_categories.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show ByteData, rootBundle;

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
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }

    return await openDatabase(path);
  }

  Future<List<TheogryCategories>> getTheogryCategoryList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM TheogryCategory');

    return List.generate(
        maps.length, (index) => TheogryCategories.fromMap(maps[index]));
  }
}
