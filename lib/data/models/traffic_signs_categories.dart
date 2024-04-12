class TrafficSignsCategories{
  int id;
  String trafficSignsType;

  TrafficSignsCategories(this.id, this.trafficSignsType);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'trafficSignsType': trafficSignsType,

    };
  }


  static TrafficSignsCategories fromMap(Map<String, dynamic> map) {
    return TrafficSignsCategories(
      map['id'],
      map['trafficSignsType'],
    );
  }
}