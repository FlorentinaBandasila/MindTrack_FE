import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
Future<bool> updateAvatar(String avatar) async {
  final token = await storage.read(key: 'token') ?? '';
  final decodedToken = JwtDecoder.decode(token);
  final userId = decodedToken[
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];

  final url =
      Uri.parse('http://192.168.1.135:5175/api/User/update-avatar/$userId');

  final response = await http.put(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
    body: jsonEncode({'avatar': avatar}),
  );

  return response.statusCode == 200;
}
