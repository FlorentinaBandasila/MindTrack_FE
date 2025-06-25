import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

class QuizResult {
  final String title;
  final DateTime date;

  QuizResult({required this.title, required this.date});
}

Future<QuizResult?> fetchLatestQuizResult() async {
  final token = await storage.read(key: 'token');
  if (token == null) return null;

  final payload = jsonDecode(
    utf8.decode(base64Url.decode(base64Url.normalize(token.split('.')[1]))),
  );
  final userId = payload[
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];

  final url = Uri.parse('http://localhost:5000/api/Quiz/user/$userId/results');
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final title = data['title'] as String;
    final date = DateTime.parse(data['date'] as String);
    return QuizResult(title: title, date: date);
  } else {
    print("Failed to fetch quiz result: ${response.statusCode}");
    return null;
  }
}
