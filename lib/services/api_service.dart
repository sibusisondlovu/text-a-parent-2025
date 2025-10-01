import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/newsletter_model.dart';


class ApiService {
  static const String baseUrl = 'https://your-laravel-backend.com/api';

  static Future<List<Newsletter>> fetchNewsletters() async {
    final response = await http.get(Uri.parse('$baseUrl/newsletters'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Newsletter.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load newsletters');
    }
  }
}
