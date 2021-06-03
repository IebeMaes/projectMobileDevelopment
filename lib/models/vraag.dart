class Vraag {
  int id;
  int blokId;
  String vraag;
  String antwoord1;
  String antwoord2;
  String antwoord3;
  String juist;

  Vraag(
      {this.id,
      this.blokId,
      this.vraag,
      this.antwoord1,
      this.antwoord2,
      this.antwoord3,
      this.juist});

  factory Vraag.fromJson(Map<String, dynamic> json) {
    return Vraag(
      id: json['id'],
      blokId: json['blokId'],
      vraag: json['vraag'],
      antwoord1: json['antwoord1'],
      antwoord2: json['antwoord2'],
      antwoord3: json['antwoord3'],
      juist: json["juist"],
    );
  }
}
