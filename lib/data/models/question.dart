class Question {
  int id;
  int typeQuestion;
  String content;
  String photo;
  bool failingGradeQuestion;
  String option1;
  String option2;
  String option3;
  String option4;
  int correctOption;
  String answerExplanation;
  bool isAnswered;

  Question(
      this.id,
      this.typeQuestion,
      this.content,
      this.photo,
      this.failingGradeQuestion,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.correctOption,
      this.answerExplanation,
      this.isAnswered);

  Question.empty():
        id = 0,
        typeQuestion = 0,
        content = '',
        photo = '',
        failingGradeQuestion = false,
        option1 = '',
        option2 = '',
        option3 = '',
        option4 = '',
        correctOption = 0,
        answerExplanation = '',
        isAnswered = false;


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'typeQuestion': typeQuestion,
      'content': content,
      'photo': photo,
      'failingGradeQuestion': failingGradeQuestion ? 1 : 0,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'correctOption': correctOption,
      'answerExplanation': answerExplanation,
      'isAnswered': isAnswered ? 1 : 0,
    };
  }

  static Question fromMap(Map<String, dynamic> map) {
    return Question(
      map['id'],
      map['typeQuestion'],
      map['content'],
      map['photo'],
      map['failingGradeQuestion'] == 1 ? true : false,
      map['option1'],
      map['option2'],
      map['option3'],
      map['option4'],
      map['correctOption'],
      map['answerExplanation'],
      map['isAnswered'] == 1 ? true : false,
    );
  }
}
