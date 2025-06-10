import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/endpoint/registeruser.dart';

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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
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
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: MyColors.cream,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/icons/left_arrow.png',
                    width: 24, height: 24),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.18,
            left: 0,
            right: 0,
            child: Container(
              width: 300,
              height: 510,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: MyColors.cream,
                border: Border.all(color: MyColors.black, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildLabel("First Name"),
                        buildTextField(_firstNameController),
                        buildLabel("Username"),
                        buildTextField(_usernameController),
                        if (_usernameError != null)
                          Text(_usernameError!,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12)),
                        buildLabel("Email"),
                        buildTextField(_emailController),
                        buildLabel("Phone Number"),
                        buildTextField(_phoneController,
                            keyboardType: TextInputType.number),
                        buildLabel("Password"),
                        buildPasswordField(
                          _passwordController,
                          _obscurePassword,
                          () {
                            setState(
                                () => _obscurePassword = !_obscurePassword);
                          },
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
                        ),
                        if (_passwordErrors.isNotEmpty)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _passwordErrors
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 15),
                                        child: Text(e,
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12)),
                                      ))
                                  .toList(),
                            ),
                          ),
                        buildLabel("Confirm Password"),
                        buildPasswordField(
                            _confirmPasswordController, _obscureConfirmPassword,
                            () {
                          setState(() => _obscureConfirmPassword =
                              !_obscureConfirmPassword);
                        }),
                        if (_confirmPasswordError != null)
                          Text(_confirmPasswordError!,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12)),
                        const SizedBox(height: 20),
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
                              final fullName = _firstNameController.text.trim();

                              setState(() {
                                _formError = null;
                                _confirmPasswordError = null;
                                _passwordErrors = [];
                              });

                              if ([
                                username,
                                password,
                                confirmPassword,
                                email,
                                phone,
                                fullName
                              ].any((e) => e.isEmpty)) {
                                _formError = 'All fields are required';
                                return;
                              }

                              if (password != confirmPassword) {
                                _confirmPasswordError =
                                    'Passwords do not match';
                                return;
                              }

                              if (password.length < 8) {
                                _passwordErrors
                                    .add('Must have minimum 8 characters');
                              }
                              if (!RegExp(r'[A-Z]').hasMatch(password)) {
                                _passwordErrors.add(
                                    'Must contain at least one uppercase letter');
                              }
                              if (!RegExp(r'[a-zA-Z]').hasMatch(password) ||
                                  !RegExp(r'[0-9]').hasMatch(password)) {
                                _passwordErrors
                                    .add('Must contain letters and numbers');
                              }

                              if (_passwordErrors.isEmpty) {
                                registerUser(context, username, password, email,
                                    phone, fullName);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.grey,
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text("Register",
                                style: TextStyle(
                                    color: MyColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        if (_formError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(_formError!,
                                style: TextStyle(color: Colors.red)),
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

  Widget buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller,
      {TextInputType? keyboardType}) {
    return SizedBox(
      width: 260,
      height: 35,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: keyboardType == TextInputType.number
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: MyColors.pink,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget buildPasswordField(
    TextEditingController controller,
    bool obscure,
    VoidCallback toggleVisibility, {
    void Function(String)? onChanged,
  }) {
    return SizedBox(
      width: 260,
      height: 35,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: MyColors.pink,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          suffixIcon: IconButton(
            icon: Icon(obscure ? Icons.visibility_off : Icons.visibility,
                size: 16, color: MyColors.black),
            onPressed: toggleVisibility,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
