import 'dart:convert';
import 'package:http/http.dart' as http;

class LanguageProvider {
  final String baseUrl = "http://10.0.2.2:8080/api/language";


  Future<String> fetchCurrentLanguage() async {
    final response = await http.get(Uri.parse("$baseUrl/current"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed to load language");
    }
  }


  Future<void> saveLanguage(String language) async {
    final response = await http.post(
      Uri.parse("$baseUrl/save"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'language': language}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to save language");
    }
  }
}
