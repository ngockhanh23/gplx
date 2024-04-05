import 'dart:math';

import '../../data/helper/database_helper.dart';
import '../../data/models/question.dart';

class QuestionServices {
  static final QuestionServices _instance = QuestionServices._internal();

  factory QuestionServices() {
    return _instance;
  }

  QuestionServices._internal();


  // List<Question> getQuestionsListByTestId(int testId){
  //   List<Question> lstQuestionsByTestID = [];
  //
  //
  //
  //   return lstQuestionsByTestID;
  // }




  List<Question> generateRandomQuestions(List<Question> allQuestions) {

    List<Question> failingQuestions = _getRandomQuestions(allQuestions, 0, true, 5);

    // failingQuestions.forEach((element) {print(element.id);});

    int countOfFallingGradeType1Question = failingQuestions.where((question)=> question.typeQuestion==1).length;
    int countOfFallingGradeType2Question = failingQuestions.where((question)=> question.typeQuestion==2).length;
    int countOfFallingGradeType3Question = failingQuestions.where((question)=> question.typeQuestion==3).length;

    print('number random fallQuestion : ${countOfFallingGradeType1Question}, ${countOfFallingGradeType2Question}, ${countOfFallingGradeType3Question}');


    // Lọc ra danh sách các câu hỏi không phải câu điểm liệt theo yêu cầu và số lượng
    List<Question> type1Questions = _getRandomQuestions(allQuestions, 1,false, 5-countOfFallingGradeType1Question).toList();
    List<Question> type2Questions = _getRandomQuestions(allQuestions, 2,false, 5-countOfFallingGradeType2Question).toList();
    List<Question> type3Questions = _getRandomQuestions(allQuestions, 3,false, 5-countOfFallingGradeType3Question).toList();
    List<Question> type4Questions = _getRandomQuestions(allQuestions, 4,false, 5).toList();
    List<Question> type5Questions = _getRandomQuestions(allQuestions, 5,false, 5).toList();


    List<Question> randomQuestions = [];
    randomQuestions.addAll(type1Questions);
    randomQuestions.addAll(type2Questions);
    randomQuestions.addAll(type3Questions);
    randomQuestions.addAll(type4Questions);
    randomQuestions.addAll(type5Questions);
    // // // Bổ sung danh sách câu hỏi ngẫu nhiên với danh sách câu hỏi có failingGradeQuestion == true
    randomQuestions.addAll(failingQuestions);
    randomQuestions.sort((a, b) => a.typeQuestion.compareTo(b.typeQuestion));


    return randomQuestions;
  }


  List<Question> _getRandomQuestions(List<Question> questions, int typeQuestion, bool failingGradeQuestion, int count) {
    Random random = Random();
    if (typeQuestion == 0) {
      List<Question> filteredQuestions = questions.where((question) => question.failingGradeQuestion == failingGradeQuestion).toList();
      return _getRandomElements(filteredQuestions, count, random);
    }

    // Lọc ra danh sách các câu hỏi không có failingGradeQuestion == true và có typeQuestion thỏa mãn
    List<Question> filteredQuestions = questions.where((question) => question.failingGradeQuestion == failingGradeQuestion && question.typeQuestion == typeQuestion).toList();
    return _getRandomElements(filteredQuestions, count, random);
  }


  List<Question> _getRandomElements<Question>(List<Question> elements, int count, Random random) {
    if (elements.length <= count) {
      return elements;
    }

    List<Question> randomElements = [];
    List<Question> remainingElements = List.from(elements);
    for (int i = 0; i < count; i++) {
      int randomIndex = random.nextInt(remainingElements.length);
      randomElements.add(remainingElements[randomIndex]);
      remainingElements.removeAt(randomIndex);
    }
    return randomElements;
  }

}