import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindtrack/models/quizmodel.dart';

Future<List<QuestionModel>> fetchQuiz() async {
  final url = Uri.parse('http://192.168.1.135:5175/api/Quiz');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => QuestionModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load quiz: ${response.statusCode}');
  }
}
