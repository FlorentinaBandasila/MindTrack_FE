import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/login.dart';
import 'package:mindtrack/main_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  List<String> _passwordErrors = [];

  Future<bool> resetPasswordWithCode(
      String email, String code, String newPassword) async {
    final url = Uri.parse("http://localhost:5000/api/User/reset-password-code");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "code": code,
          "newPassword": newPassword,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      debugPrint("Reset error: $e");
      return false;
    }
  }

  void _submitReset() async {
    final code = _codeController.text.trim();
    final password = _passwordController.text.trim();

    if (code.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in both fields.")),
      );
      return;
    }

    final success = await resetPasswordWithCode(widget.email, code, password);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset successful.")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid code or error occurred.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(color: MyColors.grey),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/icons/fundal_sus.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/icons/fundal_jos.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
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
              height: 380,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: MyColors.cream,
                border: Border.all(color: MyColors.black, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      "Please enter the code from your email \n and set a new password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter-VariableFont_opsz,wght',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 8),
                      child: Text(
                        "Confirmation Code",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter-VariableFont_opsz,wght',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 260,
                    height: 35,
                    child: TextFormField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontFamily: 'Inter-VariableFont_opsz,wght',
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: MyColors.pink,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 8),
                      child: Text(
                        "New Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter-VariableFont_opsz,wght',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 260,
                    height: 35,
                    child: SizedBox(
                      width: 260,
                      height: 35,
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        onChanged: (value) {
                          setState(() {
                            _passwordErrors = [];
                            if (value.length < 8) {
                              _passwordErrors
                                  .add('Must have minimum 8 characters');
                            }
                            if (!RegExp(r'[A-Z]').hasMatch(value)) {
                              _passwordErrors.add(
                                  'Must contain at least one uppercase letter');
                            }
                            if (!RegExp(r'[a-zA-Z]').hasMatch(value) ||
                                !RegExp(r'[0-9]').hasMatch(value)) {
                              _passwordErrors
                                  .add('Must contain letters and numbers');
                            }
                          });
                        },
                        style: const TextStyle(
                          fontFamily: 'Inter-VariableFont_opsz,wght',
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.pink,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 16,
                              color: MyColors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      width: 260,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _passwordErrors
                            .map(
                              (error) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  error,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 160,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: _submitReset,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.grey,
                        elevation: 6,
                        shadowColor: MyColors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Reset Password",
                        style: TextStyle(
                          color: MyColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter-VariableFont_opsz,wght',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
