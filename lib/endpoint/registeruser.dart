import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mindtrack/endpoint/apilogin.dart';
import 'package:mindtrack/login.dart';
import 'package:mindtrack/questions.dart';

Future<void> registerUser(
  BuildContext context,
  String username,
  String password,
  String email,
  String phone,
  String full_name,
) async {
  final url = Uri.parse(
    'http://localhost:5000/api/register',
  );
  final body = {
    "username": username,
    "password": password,
    "email": email,
    "phone": phone,
    "full_name": full_name,
  };

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      await storage.delete(key: 'selected_mood');
      await storage.delete(key: 'selected_mood_date');

      await login(context, email, password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QuizPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Register Failed"),
          content: Text("Username/Email already used"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: $e')));
  }
}
