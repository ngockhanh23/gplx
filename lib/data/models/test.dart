class Test {
  int id;
  String status;
  String description;
  int correctQuestionNumber;
  int wrongQuestionNumber;
  int fallingGradeQuestionNumber;
  int time;

  Test(this.id, this.status, this.description,
      this.correctQuestionNumber, this.wrongQuestionNumber, this.fallingGradeQuestionNumber, this.time);


  Test.empty() :
        id = 0,
        status = '',
        description = '',
        correctQuestionNumber = 0,
        wrongQuestionNumber = 0,
        fallingGradeQuestionNumber = 0,
        time = 0;




  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'description': description,
      'correctQuestionNumber' : correctQuestionNumber,
      'wrongQuestionNumber' : wrongQuestionNumber,
      'fallingGradeQuestionNumber' : fallingGradeQuestionNumber,
      'time' : time,
    };
  }


  static Test fromMap(Map<String, dynamic> map) {
    return Test(
      map['id'],
      map['status'],
      map['description'] ??'',
      map['correctQuestionNumber'],
      map['wrongQuestionNumber'],
      map['fallingGradeQuestionNumber'],
      map['time'],
    );
  }
}