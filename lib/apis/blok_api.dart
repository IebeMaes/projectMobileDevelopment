import 'dart:convert';

import 'package:campus_map/models/blok.dart';
import 'package:http/http.dart' as http;

class BlokApi {
  static String url = "https://grumpy-pig-12.loca.lt";

  static Future<List<Blok>> fetchBlokken() async {
    final response = await http.get(url + '/blokken');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((blok) => new Blok.fromJson(blok)).toList();
    } else {
      throw Exception('Failed to load blokken');
    }
  }

  static Future<Blok> fetchBlok(int id) async {
    final response = await http.get(url + '/blokken/' + id.toString());
    if (response.statusCode == 200) {
      return Blok.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load blok');
    }
  }
}
