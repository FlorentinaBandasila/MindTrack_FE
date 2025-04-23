import 'package:flutter/material.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/forgotpassword.dart';
import 'package:mindtrack/login.dart';
import 'package:mindtrack/register.dart';
import 'package:mindtrack/forgotpassword.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Top wave
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/icons/fundal_sus_lung.png',
              fit: BoxFit.cover,
            ),
          ),

          // Bottom wave
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/icons/fundal_jos_scurt.png',
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Slow down with",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter-VariableFont_opsz,wght',
                  ),
                ),
                const Text(
                  "Mind Track",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter-VariableFont_opsz,wght',
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/icons/mind.png',
                  width: 490,
                  height: 390,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 175,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 6,
                      shadowColor: MyColors.black,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: MyColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Inter-VariableFont_opsz,wght',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: 175,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.cream,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 6,
                      shadowColor: MyColors.black,
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: MyColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Inter-VariableFont_opsz,wght',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Recover Password",
                    style: TextStyle(
                      fontFamily: 'Inter-VariableFont_opsz,wght',
                      color: MyColors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
