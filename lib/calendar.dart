import 'package:flutter/material.dart';
import 'dart:math';

import 'package:mindtrack/constant/constant.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime currentMonth = DateTime(2024, 12);
  final Map<String, String> emojiMap = {
    'happy': 'assets/icons/happy.png',
    'calm': 'assets/icons/calm.png',
    'sad': 'assets/icons/sad.png',
    'angry': 'assets/icons/angry.png',
    'satisfied': 'assets/icons/satisfied.png',
    'stressed': 'assets/icons/stressed.png',
  };

  final Map<String, String> mockEmotions = {
    '2024-12-01': 'angry',
    '2024-12-02': 'stressed',
    '2024-12-03': 'sad',
    '2024-12-04': 'calm',
    '2024-12-05': 'happy',
    '2024-12-06': 'calm',
    '2024-12-11': 'calm',
    '2024-12-12': 'calm',
    '2024-12-14': 'calm',
    '2024-12-16': 'calm',
    '2024-12-17': 'calm',
    '2024-12-07': 'sad',
    '2024-12-08': 'satisfied',
    '2024-12-09': 'satisfied',
    '2024-12-10': 'happy',
    '2024-12-13': 'angry',
    '2024-12-15': 'sad',
    '2024-12-20': 'calm',
    '2024-12-25': 'sad',
    '2024-12-29': 'angry',
    '2024-12-23': 'calm',
    '2024-12-26': 'calm',
    '2025-02-15': 'angry',
  };

  void _changeMonth(int offset) {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + offset);
    });
  }

  List<Widget> _buildCalendar() {
    final daysInMonth =
        DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month);
    final firstWeekday =
        DateTime(currentMonth.year, currentMonth.month, 1).weekday;
    final dayTiles = <Widget>[];

    for (int i = 1; i < firstWeekday; i++) {
      dayTiles.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final key =
          "${currentMonth.year}-${currentMonth.month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
      final emoji = mockEmotions[key];
      dayTiles.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            emoji != null
                ? Image.asset(
                    emojiMap[emoji]!,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  )
                : const SizedBox(height: 24),
            const SizedBox(height: 4),
            Text(
              '$day',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      );
    }

    return dayTiles;
  }

  Map<String, int> _calculateEmojiStats() {
    final stats = <String, int>{};
    for (var emoji in emojiMap.keys) {
      stats[emoji] = 0;
    }

    mockEmotions.forEach((date, emoji) {
      final dt = DateTime.parse(date);
      if (dt.month == currentMonth.month && dt.year == currentMonth.year) {
        stats[emoji] = (stats[emoji] ?? 0) + 1;
      }
    });

    return stats;
  }

  @override
  Widget build(BuildContext context) {
    final stats = _calculateEmojiStats();

    return Scaffold(
      backgroundColor: MyColors.grey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 9, right: 8, bottom: 0),
          child: Column(
            children: [
              const SizedBox(height: 26),
              Container(
                width: 345,
                height: 390,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MyColors.pink,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: MyColors.black, width: 2),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _changeMonth(-1),
                          child: Image.asset('assets/icons/left_arrow.png',
                              width: 24),
                        ),
                        Text(
                          "${_monthName(currentMonth.month)} ${currentMonth.year}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () => _changeMonth(1),
                          child: Image.asset('assets/icons/right_arrow.png',
                              width: 24),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 300,
                      height: 2,
                      color: MyColors.black.withOpacity(0.5),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: SizedBox(
                        height: 15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                              ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                                  .map((e) => Expanded(
                                        child: Center(
                                          child: Text(
                                            e,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 7,
                        children: _buildCalendar(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 345,
                height: 232,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: MyColors.cream,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: MyColors.black, width: 2),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Your Monthly Progress',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 290,
                                    height: 2,
                                    color: MyColors.black.withOpacity(0.5),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: stats.entries
                                      .toList()
                                      .asMap()
                                      .entries
                                      .map((entryWithIndex) {
                                    final index = entryWithIndex.key;
                                    final entry = entryWithIndex.value;
                                    final value = entry.value;
                                    final height = (value / 10) * 160;

                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 150,
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  width: 20,
                                                  height: height,
                                                  decoration: BoxDecoration(
                                                    color: barColors[index %
                                                        barColors.length],
                                                    borderRadius:
                                                        const BorderRadius
                                                            .vertical(
                                                      top: Radius.circular(10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 2),
                                                child: Text(
                                                  '$value',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: MyColors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 2)
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: stats.entries
                                .toList()
                                .asMap()
                                .entries
                                .map((entryWithIndex) {
                              final index = entryWithIndex.key;
                              final entry = entryWithIndex.value;

                              return Column(
                                children: [
                                  Image.asset(emojiMap[entry.key]!,
                                      width: 30, height: 30),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final barColors = [
    MyColors.emojiyellow,
    MyColors.emojigreen,
    MyColors.emojilightblue,
    MyColors.emojired,
    MyColors.emojidarkblue,
    MyColors.emojipurple,
  ];

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}
