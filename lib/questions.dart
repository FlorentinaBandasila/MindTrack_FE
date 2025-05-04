import 'package:flutter/material.dart';
import 'package:mindtrack/constant/constant.dart';

class Question {
  final String text;
  final List<String> answers;

  Question({required this.text, required this.answers});
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int? selectedIndex;

  final List<Question> questions = [
    Question(
      text: "How often do you feel nervous or anxious?",
      answers: [
        "a) Never",
        "b) Sometimes",
        "c) Often",
        "d) Always",
      ],
    ),
    Question(
      text: "How often do you feel hopeless or down?",
      answers: [
        "a) Never",
        "b) Occasionally",
        "c) Frequently",
        "d) Constantly",
      ],
    ),
    Question(
      text: "How well do you sleep at night?",
      answers: [
        "a) Very well",
        "b) Fairly well",
        "c) Poorly",
        "d) Not at all",
      ],
    ),
  ];

  Question get currentQuestion => questions[currentQuestionIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: Stack(
        children: [
          // Top wave image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/icons/quizsus.png'),
          ),

          // Bottom wave image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/icons/quizjos.png'),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  // Arrows
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (currentQuestionIndex > 0) {
                              currentQuestionIndex--;
                              selectedIndex = null;
                            }
                          });
                        },
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: MyColors.cream,
                          child: Image.asset(
                            'assets/icons/left_arrow.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),

                      // Step indicator
                      Text(
                        '${currentQuestionIndex + 1} / ${questions.length}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter-VariableFont_opsz,wght',
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (currentQuestionIndex < questions.length - 1) {
                              currentQuestionIndex++;
                              selectedIndex = null;
                            }
                          });
                        },
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: MyColors.cream,
                          child: Image.asset(
                            'assets/icons/right_arrow.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Question box
                  Container(
                    width: 312,
                    height: 107,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: MyColors.pink,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: MyColors.black,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        currentQuestion.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Inter-VariableFont_opsz,wght',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  ...List.generate(currentQuestion.answers.length, (index) {
                    final isSelected = index == selectedIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Stack(
                        children: [
                          // Base button
                          Container(
                            width: 285,
                            height: 46,
                            margin: const EdgeInsets.only(bottom: 30),
                            decoration: BoxDecoration(
                              color: MyColors.cream,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  currentQuestion.answers[index],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Inter-VariableFont_opsz,wght',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Inner shadow overlay only if selected
                          if (isSelected)
                            Container(
                              width: 285,
                              height: 46,
                              margin: const EdgeInsets.only(bottom: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    MyColors.pink.withOpacity(0.2),
                                    MyColors.pink.withOpacity(0.4),
                                    MyColors.pink.withOpacity(0.7),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
