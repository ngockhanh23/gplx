import '../../data/helper/database_helper.dart';
import '../../data/models/question.dart';

class QuestionServices {
  static final QuestionServices _instance = QuestionServices._internal();

  factory QuestionServices() {
    return _instance;
  }

  QuestionServices._internal();



}