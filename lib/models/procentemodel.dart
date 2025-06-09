class WeeklyProgress {
  final int percentage;
  final int totalTasks;
  final int completedTasks;

  WeeklyProgress({
    required this.percentage,
    required this.totalTasks,
    required this.completedTasks,
  });

  factory WeeklyProgress.fromJson(Map<String, dynamic> json) {
    return WeeklyProgress(
      percentage: json['percentage'],
      totalTasks: json['totalTasks'],
      completedTasks: json['completedTasks'],
    );
  }
}
