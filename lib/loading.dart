import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/home.dart';
import 'package:mindtrack/index.dart';
import 'package:mindtrack/main_screen.dart';
import 'package:mindtrack/menu/bottom_menu.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 7), () {
      ref.read(bottomNavigatorIndex.notifier).state = 2;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              'assets/icons/loadingsus.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Transform.translate(
              offset: const Offset(0, -25),
              child: SizedBox(
                width: 450,
                height: 450,
                child: Lottie.asset('assets/animations/animatie.json'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              'assets/icons/loadingjos.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
