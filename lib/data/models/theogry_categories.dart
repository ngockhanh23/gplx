class TheogryCategories {
  int id;
  String theogryName;
  int progress;
  String photoName;

  TheogryCategories(this.id, this.theogryName, this.progress, this.photoName);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'theogryName': theogryName,
      'progress': progress,
      'photoName' : photoName
    };
  }


  static TheogryCategories fromMap(Map<String, dynamic> map) {
    return TheogryCategories(
      map['id'],
      map['theogryName'],
      map['progress'],
      map['photoName'],

    );
  }
}
