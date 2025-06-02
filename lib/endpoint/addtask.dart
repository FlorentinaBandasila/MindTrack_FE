import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mindtrack/endpoint/apilogin.dart';
import 'package:mindtrack/models/usertaskdto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
Future<void> submitUserTask(UserTaskDTO task) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    print('No token found');
    return;
  }

  final payload = jsonDecode(
    utf8.decode(base64Url.decode(base64Url.normalize(token.split('.')[1]))),
  );

  final userId = payload[
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];

  final taskWithUserId = UserTaskDTO(
    userId: userId,
    title: task.title,
    details: task.details,
    priority: task.priority,
    status: task.status,
    endDate: task.endDate,
  );

  final response = await http.post(
    Uri.parse('http://localhost:5175/api/UserTask'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(taskWithUserId.toJson()),
  );

  if (response.statusCode == 200) {
    print('Task created successfully');
  } else {
    print('Failed to create task: ${response.statusCode}');
    print(response.body);
  }
}
