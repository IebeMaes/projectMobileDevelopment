class Gebruiker {
  int id;
  String rNummer;
  String naam;
  int score;

  Gebruiker({this.id, this.rNummer, this.naam, this.score});

  factory Gebruiker.fromJson(Map<String, dynamic> json) {
    return Gebruiker(
        id: json['id'], rNummer: json['rNummer'], naam: json['naam'], score: json['score']);
  }

  Map<String, dynamic> toJson() => {'rNummer': rNummer, 'naam': naam, 'score': score};
}
