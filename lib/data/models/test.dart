class Test {
  int id;
  String status;
  String description;
  int correctQuestionNumber;
  int wrongQuestionNumber;
  int time;

  Test(this.id, this.status, this.description,
      this.correctQuestionNumber, this.wrongQuestionNumber, this.time);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'description': description,
      'correctQuestionNumber' : correctQuestionNumber,
      'wrongQuestionNumber' : wrongQuestionNumber,
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
      map['time'],
    );
  }
}