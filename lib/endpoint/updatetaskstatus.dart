import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<void> updateTaskStatus(String taskId, String status) async {
  final token = await storage.read(key: 'token') ?? '';

  final url =
      Uri.parse('http://localhost:5175/api/UserTask/$taskId/update-status');

  final response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      "status": status,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update task status: ${response.body}');
  }
}
