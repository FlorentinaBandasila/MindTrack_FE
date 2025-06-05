import 'package:flutter/material.dart';
import 'package:mindtrack/constant/constant.dart';

class JournalScreen extends StatelessWidget {
  JournalScreen({super.key});

  final List<Map<String, String>> journalEntries = [
    {
      "message": "Today I felt productive and proud of the small steps I took.",
      "date": "2025-06-05",
      "emotion": "happy.png",
    },
    {
      "message": "It was a rough day, but I’m glad I reached out to someone.",
      "date": "2025-06-04",
      "emotion": "sad.png",
    },
    {
      "message": "Grateful for the quiet moments I had alone today.",
      "date": "2025-06-03",
      "emotion": "calm.png",
    },
    {
      "message": "Anxious about what’s next, but trying to stay grounded.",
      "date": "2025-06-02",
      "emotion": "anxious.png",
    },
    {
      "message":
          "Spent time with family — felt connected and joyful.Spent time with family — felt connected and joyful.Spent time with family — felt connected and joyful.Spent time with family — felt connected and joyful.",
      "date": "2025-06-01",
      "emotion": "joyful.png",
    },
    {
      "message": "Focused and driven. Today was about progress.",
      "date": "2025-05-31",
      "emotion": "focused.png",
    },
    {
      "message": "Had a lot on my mind today. Needed quiet.",
      "date": "2025-05-30",
      "emotion": "calm.png",
    },
    {
      "message": "Feeling overwhelmed but trying to breathe through it.",
      "date": "2025-05-29",
      "emotion": "anxious.png",
    },
    {
      "message": "I made time for myself. It felt good.",
      "date": "2025-05-28",
      "emotion": "happy.png",
    },
    {
      "message": "I’m proud of how I handled discomfort today.",
      "date": "2025-05-27",
      "emotion": "strong.png",
    },
  ];

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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: journalEntries.length,
              itemBuilder: (context, index) {
                final entry = journalEntries[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: MyColors.cream,
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: MyColors.black, width: 2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                const Icon(Icons.calendar_today, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  entry['date'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            AssetImage("assets/icons/${entry['emotion']}"),
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
