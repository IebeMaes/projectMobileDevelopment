import 'package:campus_map/models/vraag.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VragenApi {
  static String url = 'https://grumpy-pig-12.loca.lt';

  static Future<List<Vraag>> fetchVragen() async {
    final response = await http.get(url + '/vragen');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((vragen) => new Vraag.fromJson(vragen)).toList();
    } else {
      throw Exception('Failed to load vragen');
    }
  }

  static Future<List<Vraag>> fetchVragenByBlokId(int id) async {
    final response = await http.get(url + '/vragen');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Vraag> alleVragen =
          jsonResponse.map((vragen) => new Vraag.fromJson(vragen)).toList();
      debugPrint(alleVragen.toString());
      List<Vraag> vragenByBlok = [];

      for (var i = 0; i < alleVragen.length; i++) {
        if (alleVragen[i].blokId == id) {
          vragenByBlok.add(alleVragen[i]);
        }
      }
      debugPrint(vragenByBlok.toString());
      return vragenByBlok;
    } else {
      throw Exception('Failed to load vragen');
    }
  }

  static Future<Vraag> fetchVraag(int id) async {
    final response = await http.get(url + '/vragen/' + id.toString());
    if (response.statusCode == 200) {
      return Vraag.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load vragen');
    }
  }

  static Future<Vraag> createVraag(Vraag vraag) async {
    final http.Response response = await http.post(
      url + '/vragen',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(vraag),
    );
    if (response.statusCode == 201) {
      return Vraag.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create vragen');
    }
  }

  static Future<Vraag> updateVraag(int id, Vraag vraag) async {
    final http.Response response = await http.put(
      url + '/vragen/' + id.toString(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(vraag),
    );
    if (response.statusCode == 200) {
      return Vraag.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update vragen');
    }
  }

  static Future deleteVraag(int id) async {
    final http.Response response =
        await http.delete(url + '/vragen/' + id.toString());
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete vragen');
    }
  }
}
