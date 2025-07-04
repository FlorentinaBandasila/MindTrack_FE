import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindtrack/models/emotionschartmodel.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

Future<List<EmotionschartModel>> getEmotionschart(int year, int month) async {
  final token = await storage.read(key: 'token');

  final payload = jsonDecode(
    utf8.decode(base64Url.decode(base64Url.normalize(token!.split('.')[1]))),
  );

  final userId = payload[
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];

  final url = Uri.parse(
      'http://192.168.1.135:5175/api/Emotion/user/$userId/mood-chart?year=$year&month=$month');

  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((item) => EmotionschartModel.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load emoji stats');
  }
}
