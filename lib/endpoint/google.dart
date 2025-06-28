import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mindtrack/completeprofile.dart';
import 'package:mindtrack/main_screen.dart'; // has baseUrl

Future<void> signInWithGoogle(BuildContext context) async {
  final storage = FlutterSecureStorage();
  final google = GoogleSignIn();

  try {
    await google.signOut();
    final user = await google.signIn();
    if (user == null) return; // user cancelled

    final email = user.email;
    final password = 'google-auth-${user.id}';

    final loginRes = await http.post(
      Uri.parse('http://192.168.1.135:5175/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'identifier': email,
        'password': password,
      }),
    );

    if (loginRes.statusCode == 200) {
      String token;
      try {
        final data = jsonDecode(loginRes.body);
        token = data['token'] as String? ?? loginRes.body;
      } catch (_) {
        token = loginRes.body;
      }

      final userId = JwtDecoder.decode(token)['nameid'].toString();
      await storage.write(key: 'token', value: token);
      await storage.write(key: 'userId', value: userId);
      await storage.delete(key: 'selected_mood');
      await storage.delete(key: 'selected_mood_date');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => CompleteProfileScreen(
          email: email,
          avatarUrl: user.photoUrl ?? 'profile1.png',
          googleId: user.id,
        ),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Google sign-in error: $e')));
  }
}
