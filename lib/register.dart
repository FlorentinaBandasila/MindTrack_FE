import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/endpoint/registeruser.dart';
import 'package:mindtrack/questions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _full_nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isChecked = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();
  List<String> _passwordErrors = [];
  String? _usernameError;
  String? _formError;
  String? _confirmPasswordError;

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
              height: 630,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: MyColors.cream,
                border: Border.all(color: MyColors.black, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "First Name and Last Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 260,
                      height: 35,
                      child: TextFormField(
                        controller: _full_nameController,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.pink,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Username",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 260,
                      height: 35,
                      child: TextFormField(
                        controller: _usernameController,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.pink,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (_usernameError != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          _usernameError!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 260,
                      height: 35,
                      child: TextFormField(
                        controller: _emailController,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.pink,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Phone Number",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 260,
                      height: 35,
                      child: TextFormField(
                        controller: _phoneController,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: const TextStyle(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.pink,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
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
                        style: const TextStyle(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.pink,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
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
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(
                          left:
                              20), // aceeasi margine ca margin-left-ul SizedBox-ului
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
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: _passwordErrors.isNotEmpty ? 8 : 14),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Confirm Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 260,
                      height: 35,
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm password is required';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.pink,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 16,
                              color: MyColors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
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
                    const SizedBox(height: 6),
                    if (_confirmPasswordError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _confirmPasswordError!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ),
                      ),
                    SizedBox(height: _confirmPasswordError != null ? 8 : 14),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: 130,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          final username = _usernameController.text.trim();
                          final password = _passwordController.text.trim();
                          final confirmPassword =
                              _confirmPasswordController.text.trim();
                          final email = _emailController.text.trim();
                          final phone = _phoneController.text.trim();
                          final fullName = _full_nameController.text.trim();

                          setState(() {
                            _formError = null;
                            _confirmPasswordError = null;
                          });

                          if (username.isEmpty ||
                              password.isEmpty ||
                              confirmPassword.isEmpty ||
                              email.isEmpty ||
                              phone.isEmpty ||
                              fullName.isEmpty) {
                            setState(() {
                              _formError = 'All fields are required';
                            });
                            return;
                          }

                          if (password != confirmPassword) {
                            setState(() {
                              _confirmPasswordError = 'Passwords do not match';
                            });
                            return;
                          }

                          registerUser(
                            context,
                            username,
                            password,
                            email,
                            phone,
                            fullName,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.grey,
                          elevation: 6,
                          shadowColor: MyColors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: MyColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (_formError != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        _formError!,
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ],
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
