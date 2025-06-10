import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindtrack/models/quizmodel.dart';

Future<List<QuestionModel>> fetchQuiz() async {
  final url = Uri.parse('http://localhost:5000/api/Quiz');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => QuestionModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load quiz: ${response.statusCode}');
  }
}
