
class Question{
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
      this.answerExplanation);

}