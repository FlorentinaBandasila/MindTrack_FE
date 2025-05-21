class EmotionschartModel {
  final String moodName;
  final int count;

  EmotionschartModel({
    required this.moodName,
    required this.count,
  });

  factory EmotionschartModel.fromJson(Map<String, dynamic> json) {
    return EmotionschartModel(
      moodName: json['moodName'],
      count: json['count'],
    );
  }
}
