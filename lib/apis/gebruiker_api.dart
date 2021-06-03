import 'package:campus_map/models/gebruiker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GebruikersApi {
  static String url = 'https://grumpy-pig-12.loca.lt';

  static Future<List<Gebruiker>> fetchGebruikers() async {
    final response = await http.get(url + '/gebruikers');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((gebruikers) => new Gebruiker.fromJson(gebruikers))
          .toList();
    } else {
      throw Exception('Failed to load gebruikers');
    }
  }

  static Future<Gebruiker> fetchGebruiker(int id) async {
    final response = await http.get(url + '/gebruikers/' + id.toString());
    if (response.statusCode == 200) {
      return Gebruiker.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load gebruikers');
    }
  }

  static Future<Gebruiker> fetchGebruikerByRnummer(String rNummer) async {
    final response = await http.get(url + "/gebruikers");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Gebruiker> alleGebruikers = jsonResponse
          .map((gebruikers) => new Gebruiker.fromJson(gebruikers))
          .toList();
      Gebruiker gebruiker;

      for (var i = 0; i < alleGebruikers.length; i++) {
        if (alleGebruikers[i].rNummer == rNummer) {
          gebruiker = alleGebruikers[i];
        }
      }
      return gebruiker;
    } else {
      throw Exception('Failed to load gebruikers');
    }
  }

  static Future<Gebruiker> createGebruiker(Gebruiker gebruiker) async {
    final http.Response response = await http.post(
      url + '/gebruikers',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(gebruiker),
    );
    if (response.statusCode == 201) {
      return Gebruiker.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create gebruikers');
    }
  }

  static Future<Gebruiker> updateGebruiker(int id, Gebruiker gebruiker) async {
    final http.Response response = await http.put(
      url + '/gebruikers/' + id.toString(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(gebruiker),
    );
    if (response.statusCode == 200) {
      return Gebruiker.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update gebruikers');
    }
  }

  static Future deleteGebruiker(int id) async {
    final http.Response response =
        await http.delete(url + '/gebruikers/' + id.toString());
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete gebruikers');
    }
  }
}
