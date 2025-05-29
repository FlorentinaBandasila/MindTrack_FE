import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mindtrack/models/quizmodel.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

Future<Map<String, dynamic>?> submitQuizAnswers(
    List<QuestionModel> questions, List<int?> selectedAnswers) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    print('No token found');
    return null;
  }

  final payload = jsonDecode(
    utf8.decode(base64Url.decode(base64Url.normalize(token.split('.')[1]))),
  );

  final userId = payload[
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];

  final List<Map<String, dynamic>> userAnswers = [];

  for (int i = 0; i < questions.length; i++) {
    final selectedIndex = selectedAnswers[i];
    if (selectedIndex != null) {
      final question = questions[i];
      final answer = question.answers[selectedIndex];
      userAnswers.add({
        "question_id": question.id,
        "answer_id": answer.id,
      });
    }
  }

  if (userAnswers.isEmpty) {
    print('No answers selected.');
    return null;
  }

  final url =
      Uri.parse('http://localhost:5175/api/Quiz/user/$userId/submit-answers');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(userAnswers),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print('Failed to submit quiz: ${response.statusCode}');
    print(response.body);
    return null;
  }
}
