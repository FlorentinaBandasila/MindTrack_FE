class MoodByDayModel {
  final String mood_Name;
  final DateTime? date;

  MoodByDayModel({
    required this.mood_Name,
    required this.date,
  });

  factory MoodByDayModel.fromJson(Map<String, dynamic> json) {
    return MoodByDayModel(
      mood_Name: json['mood_Name'],
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
    );
  }
}
