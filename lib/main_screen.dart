import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindtrack/home.dart';
import 'package:mindtrack/index.dart';
import 'package:mindtrack/login.dart';
import 'package:mindtrack/menu/bottom_menu.dart';
import 'package:mindtrack/profile.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  Widget getFragment(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return const ProfileScreen();
      case 2:
        return const HomeScreen();
      case 3:
        return const ProfileScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(bottomNavigatorIndex);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          getFragment(selectedIndex),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomMenu(),
          ),
        ],
      ),
    );
  }
}
