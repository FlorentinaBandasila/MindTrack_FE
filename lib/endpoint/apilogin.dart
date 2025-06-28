import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mindtrack/main_screen.dart';

final storage = FlutterSecureStorage();

Future<void> login(
  BuildContext context,
  String identifier,
  String password,
) async {
  final url = Uri.parse('http://192.168.1.135:5175/api/login');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'identifier': identifier, 'password': password}),
  );

  if (response.statusCode == 200) {
    final token = response.body.replaceAll('"', '');
    final savedDateStr = await storage.read(key: 'selected_mood_date');
    final now = DateTime.now();
    final savedDate =
        savedDateStr != null ? DateTime.tryParse(savedDateStr) : null;

    if (savedDate == null ||
        savedDate.year != now.year ||
        savedDate.month != now.month ||
        savedDate.day != now.day) {
      await storage.delete(key: 'selected_mood');
      await storage.delete(key: 'selected_mood_date');
    }

    await storage.write(key: 'token', value: token);

    final payload = jsonDecode(
      utf8.decode(base64Url.decode(base64Url.normalize(token.split('.')[1]))),
    );

    final userId = payload['nameidentifier'];
    final usernameFromToken = payload['name'];

    print('Logged in as: $usernameFromToken ($userId)');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Login Failed"),
        content: Text(response.body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');
}
