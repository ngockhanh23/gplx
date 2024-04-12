class TrafficSigns{
  int id;
  String images;
  String title;
  String description;
  int type;

  TrafficSigns(this.id, this.images, this.title, this.description, this.type);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'images': images,
      'title': title,
      'description': description,
      'type': type,
    };
  }


  static TrafficSigns fromMap(Map<String, dynamic> map) {
    return TrafficSigns(
      map['id'],
      map['images'],
      map['title'],
      map['description'],
      map['type'],
    );
  }
}