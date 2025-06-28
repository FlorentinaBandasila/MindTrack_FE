import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/index.dart';

class BottomMenu extends ConsumerWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int selectedIndex = ref.watch(bottomNavigatorIndex);

    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withOpacity(0.1),
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
                  color: isSelected ? MyColors.black : MyColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Image.asset(
                    icons[index],
                    width: 35,
                    height: 35,
                    color: isSelected ? MyColors.white : MyColors.black,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
