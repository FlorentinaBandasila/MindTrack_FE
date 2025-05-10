import 'package:flutter/material.dart';
import 'package:mindtrack/constant/constant.dart';

void showTaskOptionsPopup(
    BuildContext context, String title, String description, String currentTab) {
  final String taskTitle = title;
  final String taskDescription = description;

  final List<_PopupActionButton> buttons = [];

  if (currentTab == 'todo') {
    buttons.addAll([
      _PopupActionButton(label: "Abandon", color: MyColors.cream),
      _PopupActionButton(label: "Done", color: MyColors.turqouise),
    ]);
  } else if (currentTab == 'done') {
    buttons.addAll([
      _PopupActionButton(label: "Abandon", color: MyColors.cream),
      _PopupActionButton(label: "To Do", color: MyColors.turqouise),
    ]);
  } else if (currentTab == 'abandoned') {
    buttons.addAll([
      _PopupActionButton(label: "To Do", color: MyColors.cream),
      _PopupActionButton(label: "Done", color: MyColors.turqouise),
    ]);
  }

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Stack(
            children: [
              Container(
                width: 305,
                height: 250,
                padding: const EdgeInsets.only(
                    left: 20, top: 40, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: MyColors.pink,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      taskTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: MyColors.black,
                      ),
                    ),
                    Text(
                      taskDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: MyColors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: buttons
                          .map((button) => SizedBox(
                                width: 105,
                                height: 32,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: button.color,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    print(
                                        'Task "$taskTitle" moved to ${button.label}');
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    button.label,
                                    style: const TextStyle(
                                      color: MyColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, color: MyColors.black),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _PopupActionButton {
  final String label;
  final Color color;

  _PopupActionButton({required this.label, required this.color});
}
