class TestDetail{
  int id;
  int idTest;
  int idQuestion;
  int optionChoosed;
  TestDetail(this.id, this.idTest, this.idQuestion, this.optionChoosed);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idTest': idTest,
      'idQuestion': idQuestion,
      'optionChoosed' : optionChoosed,
    };
  }


  static TestDetail fromMap(Map<String, dynamic> map) {
    return TestDetail(
      map['id'] ??0,
      map['idTest']??0,
      map['idQuestion'] ??0,
      map['optionChoosed'] ?? 0,

    );
  }
}