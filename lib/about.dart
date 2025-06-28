import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindtrack/constant/constant.dart';

import 'package:mindtrack/firstpage.dart';
import 'package:mindtrack/forgotpassword.dart';
import 'package:mindtrack/home.dart';
import 'package:mindtrack/main_screen.dart';
import 'package:mindtrack/register.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
              'assets/icons/fundal_profil.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/icons/linii_about.png',
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
                  color: MyColors.pink,
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
            top: MediaQuery.of(context).size.height * 0.12,
            left: 0,
            right: 0,
            child: Container(
              width: 300,
              height: 605,
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
                  const Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    ' Mind Track is a modern mobile app and your friendly companion on the journey to better mental well-being. Designed to support self-awareness, reflection, and personal growth, it helps you understand your emotions - the first step toward healing and resilience.\n\n'
                    ' Inside the app, you’ll find a thoughtfully designed personality quiz and simple daily mood tracking tools to help you explore what’s going on in your mind and heart. Everything you share stays private and secure, so you can open up in a judgment-free space.\n\n'
                    ' Our mission is to make mental health support easy to access, proactive, and free of stigma. Whether you’re handling stress, striving for personal growth, or simply curious about your emotional patterns, Mind Track is here to guide you - one insight at a time.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.justify,
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
