import 'dart:convert';

import 'package:http/http.dart' as http;

class MoodModel {
  final String id;
  final String name;

  MoodModel({required this.id, required this.name});

  factory MoodModel.fromJson(Map<String, dynamic> json) {
    return MoodModel(
      id: json['mood_id'],
      name: json['mood'],
    );
  }
}

Future<List<MoodModel>> fetchMoodsFromBackend() async {
  final response = await http.get(
    Uri.parse('http://localhost:5175/api/MoodSelection'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((e) => MoodModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load moods');
  }
}
