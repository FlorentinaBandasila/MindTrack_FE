import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/endpoint/addemotion.dart';
import 'package:mindtrack/endpoint/getmoodselection.dart';
import 'package:mindtrack/endpoint/getprocente.dart';
import 'package:mindtrack/endpoint/getuser.dart';
import 'package:mindtrack/models/procentemodel.dart';
import 'package:mindtrack/models/usermodel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isExpanded = false;
  String selectedMood = '';
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  final storage = FlutterSecureStorage();
  final today = DateTime.now();
  UserModel? currentUser;
  String firstName = '';
  bool showError = false;
  String savedMood = '';
  bool isTextFieldFocused = false;
  WeeklyProgress? progress;
  bool moodManuallySelected = false;

  List<MoodModel> allMoods = [];
  final List<String> moodOrder = [
    "happy",
    "calm",
    "angry",
    "satisfied",
    "sad",
    "stressed"
  ];

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        isTextFieldFocused = _focusNode.hasFocus;
        isExpanded = _focusNode.hasFocus || _controller.text.trim().isNotEmpty;
      });
    });

    loadUser();
    loadProgress();
    loadMoods().then((_) {
      loadSelectedMood();
    });
  }

  Future<void> loadProgress() async {
    final fetchedProgress = await fetchWeeklyProgress();
    if (mounted) {
      setState(() {
        progress = fetchedProgress;
      });
    }
  }

  Future<void> loadSelectedMood() async {
    final mood = await storage.read(key: 'selected_mood');
    final dateStr = await storage.read(key: 'selected_mood_date');
    final now = DateTime.now();

    print("Saved mood: $mood, Saved date: $dateStr");

    if (mood != null && dateStr != null) {
      final savedDate = DateTime.tryParse(dateStr);

      if (savedDate != null &&
          savedDate.year == now.year &&
          savedDate.month == now.month &&
          savedDate.day == now.day) {
        setState(() {
          savedMood = mood;
          selectedMood = mood;
        });
        print("Mood restored: $mood");
        return;
      }
    }

    await storage.delete(key: 'selected_mood');
    await storage.delete(key: 'selected_mood_date');

    setState(() {
      savedMood = '';
      selectedMood = '';
    });
  }

  Future<void> loadMoods() async {
    try {
      final fetched = await fetchMoodsFromBackend();
      print("Moods fetched: ${fetched.map((m) => m.name).toList()}");

      fetched.sort((a, b) {
        return moodOrder.indexOf(a.name).compareTo(moodOrder.indexOf(b.name));
      });

      setState(() {
        allMoods = fetched;
      });
    } catch (e) {
      print("Error loading moods: $e");
    }
  }

  Future<void> loadUser() async {
    final user = await getUser();
    if (mounted) {
      setState(() {
        currentUser = user;
        firstName = user?.fullname ?? '';
      });
    }
  }

  Future<void> handleSave() async {
    final reflectionText = _controller.text.trim();
    final isReflection = reflectionText.isNotEmpty;
    final isNewMood = selectedMood.isNotEmpty && selectedMood != savedMood;

    if (isReflection && !isNewMood) {
      setState(() {
        selectedMood = '';
        showError = true;
      });
      return;
    }

    if (selectedMood.isEmpty) {
      setState(() => showError = true);
      return;
    }

    setState(() => showError = false);

    final mood = allMoods.firstWhere((m) => m.name == selectedMood);

    await storage.write(key: 'selected_mood', value: mood.name);
    await storage.write(
      key: 'selected_mood_date',
      value: today.toIso8601String(),
    );

    await sendEmotionToBackend(
      moodId: mood.id,
      reflection: reflectionText,
    );

    if (mounted) {
      setState(() {
        savedMood = selectedMood;
        _controller.clear();
        isExpanded = false;
        isTextFieldFocused = false;
        moodManuallySelected = false;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 9, top: 9, right: 9),
              child: Column(
                children: [
                  Container(
                    width: 345,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: MyColors.cream,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: MyColors.black, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Daily Reflection",
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style:
                                TextStyle(color: MyColors.black, fontSize: 32),
                            children: [
                              TextSpan(
                                  text:
                                      "Hello, ${firstName.isNotEmpty ? firstName : '...'}\nHow do you feel about your\n"),
                              TextSpan(
                                text: "current\nemotions?",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
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
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  focusNode: _focusNode,
                                  controller: _controller,
                                  maxLines: isExpanded ? null : 1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Your reflection...",
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: handleSave,
                                child: isExpanded
                                    ? Icon(Icons.save_as_outlined,
                                        size: 25, color: MyColors.black)
                                    : Image.asset(
                                        "assets/icons/pencil.png",
                                        width: 20,
                                        height: 20,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        if (showError)
                          Padding(
                            padding: const EdgeInsets.only(left: 9, bottom: 4),
                            child: Text(
                              "Please select a mood before saving!",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 9),
                        child: Text(
                          "Daily mood log",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: allMoods.map((mood) {
                          final imageName = mood.name.toLowerCase();
                          final isSelected = selectedMood == mood.name &&
                              (!isTextFieldFocused || moodManuallySelected);

                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                selectedMood = mood.name;
                                moodManuallySelected = true;
                                showError = false;
                              });

                              await storage.write(
                                  key: 'selected_mood', value: mood.name);
                              await storage.write(
                                  key: 'selected_mood_date',
                                  value: today.toIso8601String());

                              final reflectionText = _controller.text.trim();

                              if (reflectionText.isEmpty) {
                                await sendEmotionToBackend(
                                  moodId: mood.id,
                                  reflection: "",
                                );

                                if (mounted) {
                                  setState(() {
                                    _controller.clear();
                                    isExpanded = false;
                                  });
                                }
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: isSelected
                                        ? Border.all(
                                            color: MyColors.white, width: 3.5)
                                        : null,
                                    boxShadow: !isSelected
                                        ? [
                                            BoxShadow(
                                              color: MyColors.black
                                                  .withOpacity(0.4),
                                              offset: Offset(2, 2),
                                              blurRadius: 1,
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/icons/$imageName.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  mood.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 345,
                    height: 258,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: MyColors.turqouise,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: MyColors.darkblue,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your progress",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              flex: 63,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${progress?.percentage ?? 0}%",
                                      style: TextStyle(
                                        fontSize: 70,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
