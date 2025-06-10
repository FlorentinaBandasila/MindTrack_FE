import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mindtrack/models/taskmodel.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();
Future<List<UserTask?>> fetchUserTasks() async {
  final token = await storage.read(key: 'token');
  if (token == null) return [];

  final payload = jsonDecode(
    utf8.decode(base64Url.decode(base64Url.normalize(token.split('.')[1]))),
  );

  final userId = payload[
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];
  print('UserId from token: $userId');

  final url =
      Uri.parse('http://localhost:5000/api/UserTask/user/$userId/today');
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => UserTask.fromJson(json)).toList();
  } else {
    print('Failed to load user: ${response.body}');
    return [];
  }
}
