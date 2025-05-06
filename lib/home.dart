import 'package:flutter/material.dart';
import 'package:mindtrack/constant/constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isExpanded = false;
  String selectedMood = '';

  final moods = [
    {"id": "happy_001", "name": "happy"},
    {"id": "calm_002", "name": "calm"},
    {"id": "angry_003", "name": "angry"},
    {"id": "satisfied_004", "name": "satisfied"},
    {"id": "sad_005", "name": "sad"},
    {"id": "stressed_006", "name": "stressed"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 9, right: 9, top: 9, bottom: 0),
            child: Column(
              children: [
                Container(
                  width: 345,
                  height: isExpanded ? null : 335,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE7DC),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: MyColors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Daily Reflection", style: TextStyle(fontSize: 14)),
                      SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: MyColors.black, fontSize: 32),
                          children: [
                            TextSpan(
                                text:
                                    "Hello, Flory\nHow do you feel about your\n"),
                            TextSpan(
                                text: "current\nemotions?",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Container(
                          width: 305,
                          height: isExpanded ? 100 : 35,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: MyColors.pink,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: MyColors.grey,
                                  offset: Offset(2, 2),
                                  blurRadius: 5),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  maxLines: isExpanded ? null : 1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Your reflection...",
                                  ),
                                ),
                              ),
                              Image.asset("assets/icons/pencil.png",
                                  width: 20, height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Daily mood log",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: moods.map((mood) {
                        final name = mood['name']!;
                        final id = mood['id']!;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedMood = name;
                            });
                            //print("Selected mood ID: $id");
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: selectedMood == name
                                      ? Border.all(
                                          color: MyColors.white, width: 2)
                                      : null,
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/icons/$name.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                name[0].toUpperCase() + name.substring(1),
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: 345,
                  height: 247,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: MyColors.turqouise,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: MyColors.darkblue),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your progress",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 63,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "100%",
                                    style: TextStyle(
                                        fontSize: 70,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 37,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Of the weekly\nplan completed",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
