import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindtrack/models/usermodel.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

Future<UserModel?> fetchUser() async {
  final token = await storage.read(key: 'token');
  if (token == null) return null;

  final payload = jsonDecode(
    utf8.decode(base64Url.decode(base64Url.normalize(token.split('.')[1]))),
  );

  final userId = payload[
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];
  print('UserId from token: $userId');

  final url = Uri.parse('http://localhost:5175/api/User/$userId');
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final userJson = jsonDecode(response.body);
    return UserModel.fromJson(userJson);
  } else {
    print('Failed to load user: ${response.body}');
    return null;
  }
}
