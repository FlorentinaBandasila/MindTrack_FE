class UserTaskDTO {
  final String userId;
  final String title;
  final String details;
  final String priority;
  final String status;
  final DateTime endDate;

  UserTaskDTO({
    required this.userId,
    required this.title,
    required this.details,
    required this.priority,
    required this.status,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'User_id': userId,
      'Title': title,
      'Details': details,
      'Priority': priority,
      'Status': status,
      'End_date': endDate.toIso8601String(),
    };
  }
}
