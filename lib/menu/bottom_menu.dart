import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindtrack/index.dart';

class BottomMenu extends ConsumerWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int selectedIndex = ref.watch(bottomNavigatorIndex);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (index) {
            final icons = [
              "assets/icons/coffee.png",
              "assets/icons/date.png",
              "assets/icons/home.png",
              "assets/icons/bell.png",
              "assets/icons/account.png"
            ];
            final isSelected = index == selectedIndex;
            return GestureDetector(
              onTap: () {
                ref.read(bottomNavigatorIndex.notifier).state = index;
              },
              child: SizedBox(
                width: 50,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Image.asset(
                      icons[index],
                      width: 35,
                      height: 35,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
