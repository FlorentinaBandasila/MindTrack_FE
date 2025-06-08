import 'package:flutter/material.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/endpoint/getquiz.dart';
import 'package:mindtrack/endpoint/takequiz.dart';
import 'package:mindtrack/loading.dart';
import 'package:mindtrack/models/quizmodel.dart';

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

  final List<int?> selectedAnswers = [];

  List<QuestionModel> questions = [];
  bool _isLoadingQuestions = true;

  QuestionModel? get currentQuestion =>
      questions.isNotEmpty ? questions[currentQuestionIndex] : null;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      final fetchedQuestions = await fetchQuiz();
      setState(() {
        questions = fetchedQuestions;
        selectedAnswers.addAll(List<int?>.filled(questions.length, null));
        _isLoadingQuestions = false;
      });
    } catch (e) {
      print('Error loading quiz: $e');
      setState(() {
        _isLoadingQuestions = false;
      });
    }
  }

  void saveResults() async {
    final result = await submitQuizAnswers(questions, selectedAnswers);

    if (result != null) {
      print("Quiz submitted successfully:");
      print("Result ID: ${result['quizResult_id']}");
      print("Points: ${result['points']}");
      print("Title: ${result['title']}");
      print("Date: ${result['date']}");
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoadingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingQuestions) {
      return const Scaffold(
        backgroundColor: MyColors.grey,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (questions.isEmpty) {
      return const Scaffold(
        backgroundColor: MyColors.grey,
        body: Center(child: Text("No questions available.")),
      );
    }

    final question = currentQuestion;
    if (question == null) {
      return const Scaffold(
        backgroundColor: MyColors.grey,
        body: Center(child: Text("Loading question...")),
      );
    }

    return Scaffold(
      backgroundColor: MyColors.grey,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/icons/quizsus.png'),
          ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentQuestionIndex > 0
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentQuestionIndex--;
                                  selectedIndex =
                                      selectedAnswers[currentQuestionIndex];
                                });
                              },
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: MyColors.cream,
                                child: Image.asset(
                                  'assets/icons/left_arrow.png',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            )
                          : const SizedBox(width: 34),
                      Text(
                        '${currentQuestionIndex + 1} / ${questions.length}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter-VariableFont_opsz,wght',
                        ),
                      ),
                      currentQuestionIndex < questions.length - 1
                          ? Opacity(
                              opacity: selectedIndex == null ? 0.5 : 1.0,
                              child: GestureDetector(
                                onTap: selectedIndex == null
                                    ? null
                                    : () {
                                        setState(() {
                                          selectedAnswers[
                                                  currentQuestionIndex] =
                                              selectedIndex;
                                          currentQuestionIndex++;
                                          selectedIndex = selectedAnswers[
                                              currentQuestionIndex];
                                        });
                                      },
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: MyColors.cream,
                                  child: Image.asset(
                                    'assets/icons/right_arrow.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(width: 34),
                    ],
                  ),
                  const SizedBox(height: 24),
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
                        currentQuestion!.title,
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
                  ...List.generate(currentQuestion!.answers.length, (index) {
                    final answer = currentQuestion!.answers[index];
                    final isSelected = index == selectedIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          selectedAnswers[currentQuestionIndex] = index;
                        });
                      },
                      child: Stack(
                        children: [
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
                                  answer.text, // AICI: afișăm answer.text
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Inter-VariableFont_opsz,wght',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (isSelected)
                            Container(
                              width: 285,
                              height: 46,
                              margin: const EdgeInsets.only(bottom: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: MyColors.black,
                                  width: 1,
                                ),
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
                  if (currentQuestionIndex == questions.length - 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        width: 140,
                        child: ElevatedButton(
                          onPressed: selectedIndex == null ? null : saveResults,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.grey,
                            foregroundColor: MyColors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side:
                                  BorderSide(color: MyColors.black, width: 1.5),
                            ),
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
