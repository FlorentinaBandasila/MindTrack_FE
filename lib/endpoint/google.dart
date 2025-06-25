import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mindtrack/completeprofile.dart';
import 'package:mindtrack/main_screen.dart';
import 'package:mindtrack/questions.dart'; // Importă pagina de completare
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mindtrack/main_screen.dart';
import 'package:mindtrack/questions.dart'; // asigură-te că ai acest import

Future<void> signInWithGoogle(BuildContext context) async {
  final storage = FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  try {
    await _googleSignIn.signOut(); // resetare
    final user = await _googleSignIn.signIn();

    if (user == null) {
      print("Sign-in cancelled");
      return;
    }

    final email = user.email;
    final password = "google-auth-${user.id}";

    final loginUrl = Uri.parse('http://localhost:5000/api/login');
    final loginBody = jsonEncode({
      "identifier": email,
      "password": password,
    });

    final loginResponse = await http.post(
      loginUrl,
      headers: {"Content-Type": "application/json"},
      body: loginBody,
    );

    if (loginResponse.statusCode == 200) {
      final token = loginResponse.body; // JWT token direct
      final userId = JwtDecoder.decode(token)['nameid'];

      await storage.write(key: 'token', value: token);
      await storage.write(key: 'userId', value: userId);

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
          email: user.email,
          avatarUrl: user.photoUrl ?? "profile1.png",
          googleId: user.id,
        ),
      ),
    );
  } catch (e) {
    print("Sign-in error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sign-in failed: $e')),
    );
  }
}
