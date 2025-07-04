import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mindtrack/questions.dart';
import 'package:mindtrack/constant/constant.dart';

class CompleteProfileScreen extends StatefulWidget {
  final String email;
  final String avatarUrl;
  final String googleId;

  const CompleteProfileScreen({
    super.key,
    required this.email,
    required this.avatarUrl,
    required this.googleId,
  });

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _error;

  Future<void> _submitProfile() async {
    if (_fullNameController.text.trim().isEmpty ||
        _usernameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty) {
      setState(() => _error = 'Please complete all fields');
      return;
    }

    setState(() => _error = null);

    final body = jsonEncode({
      "username": _usernameController.text.trim(),
      "full_name": _fullNameController.text.trim(),
      "email": widget.email,
      "avatar": widget.avatarUrl,
      "phone": _phoneController.text.trim(),
      "password": "google-auth-${widget.googleId}",
    });

    final res = await http.post(
      Uri.parse('http://192.168.1.135:5175/api/register/google'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final token = data['token'] as String?;
      if (token == null) {
        setState(() => _error = 'No token returned.');
        return;
      }

      final userId = JwtDecoder.decode(token)['nameid'].toString();
      final storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: token);
      await storage.write(key: 'userId', value: userId);
      await storage.delete(key: 'selected_mood');
      await storage.delete(key: 'selected_mood_date');
      // now go to quiz
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const QuizPage()),
      );
    } else {
      setState(() => _error = 'Registration failed: Username already exists');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: MyColors.grey)),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child:
                Image.asset('assets/icons/fundal_sus.png', fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child:
                Image.asset('assets/icons/fundal_jos.png', fit: BoxFit.cover),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: MyColors.cream,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/icons/left_arrow.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.18,
            left: 0,
            right: 0,
            child: Container(
              width: 300,
              height: 330,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: MyColors.cream,
                border: Border.all(color: MyColors.black, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Scrollbar(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildLabel("First Name"),
                        _buildTextField(_fullNameController),
                        _buildLabel("Username"),
                        _buildTextField(_usernameController),
                        _buildLabel("Phone Number"),
                        _buildTextField(_phoneController,
                            keyboardType: TextInputType.phone),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 130,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: _submitProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.grey,
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text("Submit",
                                style: TextStyle(
                                    color: MyColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        if (_error != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(_error!,
                                style: const TextStyle(color: Colors.red)),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller,
      {TextInputType? keyboardType}) {
    return SizedBox(
      width: 260,
      height: 35,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: keyboardType == TextInputType.phone
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: MyColors.pink,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
