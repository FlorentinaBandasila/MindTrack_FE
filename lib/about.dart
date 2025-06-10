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
            top: MediaQuery.of(context).size.height * 0.16,
            left: 0,
            right: 0,
            child: Container(
              width: 300,
              height: 540,
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
                    'MindTrack is a modern mobile application designed to support mental well-being through self-awareness, reflection, and personal growth.\n\n'
                    'We believe that understanding your emotions is the first step toward healing and resilience.\n\n'
                    'With interactive features such as personality quizzes and mood tracking, MindTrack helps users explore their inner world in a safe and private space.\n\n'
                    'Our goal is to make mental health support more accessible, proactive, and stigma-free. Whether you\'re navigating stress, working on self-improvement, or simply curious about your psychological patterns, MindTrack is here to guide you — one insight at a time.',
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
