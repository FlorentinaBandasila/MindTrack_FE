import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/home.dart';
import 'package:mindtrack/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Gray background
          Container(color: MyColors.grey),

          // Top wave
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/icons/fundal_sus.png',
              fit: BoxFit.cover,
            ),
          ),

          // Bottom wave
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/icons/fundal_jos.png',
              fit: BoxFit.cover,
            ),
          ),

          // Back arrow circle
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
              height: 550,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: MyColors.cream,
                border: Border.all(color: MyColors.black, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
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
                          fontFamily: 'Inter-VariableFont_opsz,wght',
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
                      style: const TextStyle(
                        fontFamily: 'Inter-VariableFont_opsz,wght',
                      ),
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
                          fontFamily: 'Inter-VariableFont_opsz,wght',
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
                      style: const TextStyle(
                        fontFamily: 'Inter-VariableFont_opsz,wght',
                      ),
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
                        "Email",
                        style: TextStyle(
                          fontFamily: 'Inter-VariableFont_opsz,wght',
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
                      style: const TextStyle(
                        fontFamily: 'Inter-VariableFont_opsz,wght',
                      ),
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
                          fontFamily: 'Inter-VariableFont_opsz,wght',
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
                      style: const TextStyle(
                        fontFamily: 'Inter-VariableFont_opsz,wght',
                      ),
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
                          fontFamily: 'Inter-VariableFont_opsz,wght',
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
                      obscureText: _obscureText,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        fontFamily: 'Inter-VariableFont_opsz,wght',
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: MyColors.pink,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 16,
                            color: MyColors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
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
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                          fontFamily: 'Inter-VariableFont_opsz,wght',
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
                      obscureText: _obscureText,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        fontFamily: 'Inter-VariableFont_opsz,wght',
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: MyColors.pink,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 16,
                            color: MyColors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
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
                  const SizedBox(height: 35),
                  SizedBox(
                    width: 120,
                    height: 25,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_usernameController.text.isEmpty &&
                            _passwordController.text.isEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ),
                          );
                        }
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
                          fontFamily: 'Inter-VariableFont_opsz,wght',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
