class QuestionSaved {
  int idQuestion;

  QuestionSaved(this.idQuestion);

  Map<String, dynamic> toMap() {
    return {
      'idQuestion': idQuestion,

    };
  }


  static QuestionSaved fromMap(Map<String, dynamic> map) {
    return QuestionSaved(
      map['idQuestion'],
    );
  }
}