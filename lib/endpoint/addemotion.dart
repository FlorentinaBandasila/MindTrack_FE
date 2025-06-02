import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mindtrack/models/addemotionmodel.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

Future<void> sendEmotionToBackend({
  required String moodId,
  required String reflection,
}) async {
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

  final emotion = AddEmotionDTO(
    userId: userId,
    moodId: moodId,
    reflection: reflection,
    date: DateTime.now(),
  );

  final response = await http.post(
    Uri.parse('http://localhost:5175/api/Emotion'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(emotion.toJson()),
  );

  if (response.statusCode == 200) {
    print('Emotion sent successfully');
  } else {
    print('Failed to send emotion: ${response.statusCode}');
    print(response.body);
  }
}
