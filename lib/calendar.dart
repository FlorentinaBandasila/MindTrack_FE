import 'package:flutter/material.dart';
import 'dart:math';

import 'package:mindtrack/constant/constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindtrack/endpoint/getemotionschart.dart';
import 'package:mindtrack/endpoint/getmoodbyday.dart';
import 'package:mindtrack/models/emotionschartmodel.dart';
import 'package:mindtrack/models/moodbydaymodel.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime currentMonth = DateTime.now();
  final Map<String, String> emojiMap = {
    'happy': 'assets/icons/happy.png',
    'calm': 'assets/icons/calm.png',
    'sad': 'assets/icons/sad.png',
    'angry': 'assets/icons/angry.png',
    'satisfied': 'assets/icons/satisfied.png',
    'stressed': 'assets/icons/stressed.png',
  };

  List<MoodByDayModel> _moods = [];
  bool _isLoading = true;

  Map<String, int> emojiStats = {};

  @override
  void initState() {
    super.initState();
    _fetchEmojiStats();
    _fetchMoods();
  }

  Future<void> _fetchMoods() async {
    try {
      final allMoods =
          await getmoodbyday(currentMonth.year, currentMonth.month);
      if (allMoods != null) {
        final filtered = allMoods
            .where((m) {
              final d = m?.date;
              return d != null &&
                  d.year == currentMonth.year &&
                  d.month == currentMonth.month;
            })
            .cast<MoodByDayModel>()
            .toList();

        setState(() {
          _moods = filtered;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching moods: $e');
      setState(() => _isLoading = false);
    }
  }

  Map<String, String> _generateMoodMap() {
    final Map<String, String> moodMap = {};

    for (var mood in _moods) {
      final date = mood.date;
      if (date != null &&
          date.year == currentMonth.year &&
          date.month == currentMonth.month) {
        final key =
            "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        moodMap.putIfAbsent(key, () => mood.mood_Name.toLowerCase());
      }
    }

    return moodMap;
  }

  Future<void> _fetchEmojiStats() async {
    try {
      final data =
          await getEmotionschart(currentMonth.year, currentMonth.month);

      final Map<String, int> stats = {
        'happy': 0,
        'calm': 0,
        'sad': 0,
        'angry': 0,
        'satisfied': 0,
        'stressed': 0,
      };

      for (var item in data) {
        if (item != null && stats.containsKey(item.moodName.toLowerCase())) {
          stats[item.moodName.toLowerCase()] = item.count;
        }
      }

      setState(() {
        emojiStats = stats;
      });
    } catch (e) {
      print('Error fetching emoji stats: $e');
    }
  }

  void _changeMonth(int offset) {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + offset);
      _isLoading = true;
    });

    _fetchMoods();
    _fetchEmojiStats();
  }

  List<Widget> _buildCalendar() {
    final daysInMonth =
        DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month);
    final firstWeekday =
        DateTime(currentMonth.year, currentMonth.month, 1).weekday;
    final dayTiles = <Widget>[];
    final moodMap = _generateMoodMap();

    for (int i = 1; i < firstWeekday; i++) {
      dayTiles.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final key =
          "${currentMonth.year}-${currentMonth.month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
      final emoji = moodMap[key];

      dayTiles.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            emoji != null && emojiMap.containsKey(emoji)
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

  @override
  Widget build(BuildContext context) {
    final stats = emojiStats.isEmpty
        ? {
            'happy': 0,
            'calm': 0,
            'sad': 0,
            'angry': 0,
            'satisfied': 0,
            'stressed': 0,
          }
        : emojiStats;

    return Scaffold(
      backgroundColor: MyColors.grey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 9, top: 9, right: 9, bottom: 0),
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
}
