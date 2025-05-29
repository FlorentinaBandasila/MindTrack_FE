class UserTask {
  final String id;
  final String title;
  final String priority;
  final String status;
  final String endDate;
  final String createdDate;
  final String details;
  final String categoryId;
  final String userId;

  UserTask({
    required this.id,
    required this.title,
    required this.priority,
    required this.status,
    required this.endDate,
    required this.createdDate,
    required this.details,
    required this.categoryId,
    required this.userId,
  });

  factory UserTask.fromJson(Map<String, dynamic> json) {
    return UserTask(
      id: json['task_id'],
      title: json['title'],
      priority: json['priority'],
      status: json['status'],
      endDate: json['end_date'],
      createdDate: json['created_date'],
      details: json['details'],
      categoryId: json['category_id'],
      userId: json['user_id'],
    );
  }
}
