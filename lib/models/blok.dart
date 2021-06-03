class Blok {
  int id;
  String title;
  String description;
  double longitude;
  double latitude;

  Blok({this.id, this.title, this.description, this.longitude, this.latitude});

  factory Blok.fromJson(Map<String, dynamic> json) {
    return Blok(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'longitude': longitude,
        'latitude': latitude
      };
}
