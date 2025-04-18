import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindtrack/home.dart';
import 'package:mindtrack/navbar.dart';

final bottomNavigatorIndex = StateProvider<int>((ref) => 1);

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  Widget getFragment(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const HomeScreen();
      case 2:
        return const HomeScreen();
    }
    return const HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getFragment(ref.watch(bottomNavigatorIndex)),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}