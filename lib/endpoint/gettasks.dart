import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindtrack/models/taskmodel.dart';

Future<List<UserTask>> fetchUserTasks() async {
  final response = await http.get(
    Uri.parse('http://localhost:5175/api/UserTask'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => UserTask.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load tasks');
  }
}
