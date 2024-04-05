import 'package:gplx/data/helper/database_helper.dart';
import 'package:gplx/data/models/question.dart';
import 'package:gplx/services/data_services/question_services.dart';

class TestServices{
  Future<void> createNewRandomTest() async{
    List<Question> lstAllQuestions = await DatabaseHelper().getAllQuestions();

    List<Question> lstRandomQuestions = QuestionServices().generateRandomQuestions(lstAllQuestions);

    DatabaseHelper().createNewTest(lstRandomQuestions);

  }
}