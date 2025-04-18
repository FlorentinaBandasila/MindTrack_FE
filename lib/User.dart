class User {
  final String userId;
  final String username;
  final String password;
  final String email;
  final String phone;
  final String fullName;

  User({
    required this.userId,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.fullName,
  });

  // Factory constructor to parse from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      fullName: json['full_name'] as String,
    );
  }
}
