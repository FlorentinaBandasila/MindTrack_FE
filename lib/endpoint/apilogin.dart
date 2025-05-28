import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mindtrack/main_screen.dart';

final storage = FlutterSecureStorage();

Future<void> login(
  BuildContext context,
  String username,
  String password,
) async {
  final url = Uri.parse('http://192.168.1.133:5000/api/login');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'username': username, 'password': password}),
  );

  if (response.statusCode == 200) {
    final token = response.body.replaceAll('"', '');
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
