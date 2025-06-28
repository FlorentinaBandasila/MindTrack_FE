import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindtrack/models/articlemodel.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

Future<List<ArticleModel>> getArticle() async {
  final response = await http.get(
    Uri.parse('http://192.168.1.135:5175/api/Article'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((item) => ArticleModel.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load article');
  }
}
