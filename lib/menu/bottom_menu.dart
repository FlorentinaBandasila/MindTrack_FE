import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindtrack/constant/constant.dart';

class BottomMenu extends ConsumerStatefulWidget {
  const BottomMenu({super.key});

  @override
  ConsumerState<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends ConsumerState<BottomMenu> {
  final bottomNavigatorIndex = StateProvider<int>((ref) => 0);
  void _onItemTapped(int index) {
    ref.read(bottomNavigatorIndex.notifier).state = index;
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = ref.watch(bottomNavigatorIndex);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedLabelStyle:
          const TextStyle(fontFamily: 'Inter-VariableFont_opsz,wght'),
      unselectedLabelStyle:
          const TextStyle(fontFamily: 'Inter-VariableFont_opsz,wght'),
      items: [
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: Image.asset("assets/icons/bell.png"),
          ),
          label: 'Bell',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: Image.asset("assets/icons/coffee.png"),
          ),
          label: 'Coffee',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: Image.asset("assets/icons/home.png"),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: Image.asset("assets/icons/date.png"),
          ),
          label: 'Date',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: Image.asset("assets/icons/account.png"),
          ),
          label: 'Account',
        ),
      ],
    );
  }
}
