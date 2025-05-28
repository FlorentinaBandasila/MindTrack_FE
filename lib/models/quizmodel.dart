class Answer {
  final String id;
  final String text;
  final int points;

  Answer({
    required this.id,
    required this.text,
    required this.points,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['answer_id'],
      text: json['answer_name'],
      points: json['points'],
    );
  }
}

class QuestionModel {
  final String id;
  final String title;
  final List<Answer> answers;

  QuestionModel({
    required this.id,
    required this.title,
    required this.answers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final answersJson = json['answers'] as List<dynamic>;
    final answers = answersJson.map((e) => Answer.fromJson(e)).toList();

    return QuestionModel(
      id: json['question_id'],
      title: json['title'],
      answers: answers,
    );
  }
}
