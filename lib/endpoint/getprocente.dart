import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mindtrack/models/procentemodel.dart';

final storage = FlutterSecureStorage();

Future<WeeklyProgress?> fetchWeeklyProgress() async {
  final token = await storage.read(key: 'token');
  if (token == null) return null;

  final payload = jsonDecode(
    utf8.decode(base64Url.decode(base64Url.normalize(token.split('.')[1]))),
  );

  final userId = payload[
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];

  final url = Uri.parse(
      'http://localhost:5175/api/UserTask/user/$userId/weekly-progress');
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return WeeklyProgress.fromJson(data);
  } else {
    print('Failed to load weekly progress: ${response.body}');
    return null;
  }
}
