import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<void> patchUser(List<Map<String, dynamic>> patchOperations) async {
  final token = await storage.read(key: 'token') ?? '';
  final decodedToken = JwtDecoder.decode(token);
  final userId = decodedToken[
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];

  final url = Uri.parse('http://localhost:5175/api/User/$userId');

  final response = await http.patch(
    url,
    headers: {
      "Content-Type": "application/json-patch+json",
      "Authorization": "Bearer $token",
    },
    body: jsonEncode(patchOperations),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update user: ${response.body}');
  }
}
