import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mindtrack/constant/constant.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  List<Map<String, String>> journalEntries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJournalEntries();
  }

  Future<void> fetchJournalEntries() async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      print('No token found');
      return null;
    }

    final payload = jsonDecode(
      utf8.decode(base64Url.decode(base64Url.normalize(token.split('.')[1]))),
    );

    final userId = payload[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];

    final url = Uri.parse(
        'http://localhost:5175/api/Emotion/user/${userId}/journal-by-user');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          journalEntries = data
              .where(
                  (entry) => (entry["reflection"]?.trim().isNotEmpty ?? false))
              .map<Map<String, String>>((entry) {
            return {
              "message": entry["reflection"],
              "date": entry["date"]?.substring(0, 10) ?? "",
              "emotion":
                  "${entry["mood_Name"]?.toLowerCase() ?? 'neutral'}.png",
            };
          }).toList();

          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/icons/jurnal_jos.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : journalEntries.isEmpty
                    ? const Center(child: Text("No journal entries available."))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        itemCount: journalEntries.length,
                        itemBuilder: (context, index) {
                          final entry = journalEntries[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: MyColors.cream,
                              borderRadius: BorderRadius.circular(26),
                              border:
                                  Border.all(color: MyColors.black, width: 2),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'My Reflection',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        entry['message'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          height: 1.4,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          const Icon(Icons.calendar_today,
                                              size: 14),
                                          const SizedBox(width: 4),
                                          Text(
                                            entry['date'] ?? '',
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: AssetImage(
                                      "assets/icons/${entry['emotion']}"),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: MyColors.pink,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/icons/left_arrow.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Journal',
                  style: TextStyle(
                    fontSize: 22,
                    color: MyColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
