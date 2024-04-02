class TheogryCategories {
  int id;
  String theogryName;
  int progress;

  TheogryCategories(this.id, this.theogryName, this.progress);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'theogryName': theogryName,
      'progress': progress,
    };
  }


  static TheogryCategories fromMap(Map<String, dynamic> map) {
    return TheogryCategories(
      map['id'],
      map['theogryName'],
      map['progress'],
    );
  }
}
