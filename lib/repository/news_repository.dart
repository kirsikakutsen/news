import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as https;
import 'package:news/models/news_model.dart';

Future<List<NewsResponse>> fetchNews(String locale) async {
  final apiKey = dotenv.env['API_KEY'];
  final baseUrl = dotenv.env['BASE_URL'];
  final uriString = "$baseUrl/api/1/latest?apikey=$apiKey&language=$locale";
  final uri = Uri.parse(uriString);

  final response = await https.get(
    uri,
    headers: {
      'Accept-Charset': 'utf-8',
      'Content-Type': 'application/json; charset=utf-8',
    },
  );

  if (response.statusCode == 200) {
    try {
      final String responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> json = jsonDecode(responseBody);
      var results = json["results"] as List;
      var models = results.map((item) => NewsResponse.fromJson(item)).toList();
      return models;
    } catch (e) {
      throw Exception("Failed to parse news data: $e");
    }
  } else {
    throw Exception("Failed to fetch news data: ${response.statusCode}");
  }
}
