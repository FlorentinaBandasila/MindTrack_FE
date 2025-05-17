class UserModel {
  final String username;
  final String email;
  final String phone;
  final String fullname;
  final DateTime? createdAt;

  UserModel({
    required this.username,
    required this.email,
    required this.phone,
    required this.fullname,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      fullname: json['full_name'],
      createdAt:
          json['created'] != null ? DateTime.tryParse(json['created']) : null,
    );
  }
}
