// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// /// User model to match your API response
// class User {
//   final String userId;
//   final String username;
//   final String password;
//   final String email;
//   final String phone;
//   final String fullName;

//   User({
//     required this.userId,
//     required this.username,
//     required this.password,
//     required this.email,
//     required this.phone,
//     required this.fullName,
//   });

//   /// Converts a JSON map into a User instance
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       userId: json['user_id'] as String,
//       username: json['username'] as String,
//       password: json['password'] as String,
//       email: json['email'] as String,
//       phone: json['phone'] as String,
//       fullName: json['full_name'] as String,
//     );
//   }
// }

// /// Service class for fetching data from .NET
// class UserService {
//   /// Change to match your local or deployed .NET endpoint
//   static const String baseUrl = 'http://localhost:5175/api/User';

//   /// Fetches all users and returns a List of User objects
//   Future<List<User>> fetchUsers() async {
//     try {
//       final url = Uri.parse(baseUrl);
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonList = jsonDecode(response.body);
//         return jsonList.map((item) => User.fromJson(item)).toList();
//       } else {
//         debugPrint('Failed to load users. Status code: ${response.statusCode}');
//         return [];
//       }
//     } catch (e) {
//       debugPrint('Error fetching users: $e');
//       return [];
//     }
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

// /// Root widget
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'First User Details',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const UserDetailsScreen(),
//     );
//   }
// }

// /// Screen that displays the first user's details
// class UserDetailsScreen extends StatefulWidget {
//   const UserDetailsScreen({super.key});

//   @override
//   State<UserDetailsScreen> createState() => _UserDetailsScreenState();
// }

// class _UserDetailsScreenState extends State<UserDetailsScreen> {
//   final _userService = UserService();
//   late Future<List<User>> _futureUsers;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch the entire list on startup
//     _futureUsers = _userService.fetchUsers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Details Demo'),
//       ),
//       body: FutureBuilder<List<User>>(
//         future: _futureUsers,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Loading spinner while we fetch data
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             // Show an error if something went wrong
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             // If we get an empty list or null data
//             return const Center(child: Text('No users found.'));
//           } else {
//             // We have at least one user. Display the first user's details.
//             final user = snapshot.data!.first;
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Card(
//                 elevation: 4.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'User Details',
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       const Divider(thickness: 2.0),
//                       const SizedBox(height: 8.0),
//                       _buildDetailRow('User ID', user.userId),
//                       _buildDetailRow('Username', user.username),
//                       _buildDetailRow('Full Name', user.fullName),
//                       _buildDetailRow('Email', user.email),
//                       _buildDetailRow('Phone', user.phone),
//                       // Show password or not? Usually you'd keep it hidden
//                       _buildDetailRow('Password', '*********'),
//                       const SizedBox(height: 16.0),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Reload the first user (or do something else)
//                           setState(() {
//                             _futureUsers = _userService.fetchUsers();
//                           });
//                         },
//                         child: const Text('Refresh'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   /// Helper widget to display a label-value pair nicely
//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Text(
//             '$label: ',
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Expanded(
//             child: Text(value),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindtrack/home.dart';
import 'package:mindtrack/login.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

