class AddEmotionDTO {
  final String userId;
  final String moodId;
  final String reflection;
  final DateTime date;

  AddEmotionDTO({
    required this.userId,
    required this.moodId,
    required this.reflection,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'mood_id': moodId,
      'reflection': reflection,
      'date': date.toIso8601String(),
    };
  }
}
