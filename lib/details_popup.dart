import 'package:flutter/material.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/endpoint/updatetaskstatus.dart';

void showTaskOptionsPopup(
  BuildContext context,
  String taskId,
  String title,
  String description,
  String currentTab, {
  VoidCallback? onStatusChanged,
}) {
  final String taskTitle = title;
  final String taskDescription = description;

  final List<_PopupActionButton> buttons = [];

  String formatLabel(String label) {
    if (label == 'todo') return 'To Do';
    if (label == 'done') return 'Done';
    if (label == 'abandoned') return 'Abandon';
    return label;
  }

  if (currentTab == 'todo') {
    buttons.addAll([
      _PopupActionButton(label: "abandoned", color: MyColors.cream),
      _PopupActionButton(label: "done", color: MyColors.turqouise),
    ]);
  } else if (currentTab == 'done') {
    buttons.addAll([
      _PopupActionButton(label: "abandoned", color: MyColors.cream),
      _PopupActionButton(label: "todo", color: MyColors.turqouise),
    ]);
  } else if (currentTab == 'abandoned') {
    buttons.addAll([
      _PopupActionButton(label: "todo", color: MyColors.cream),
      _PopupActionButton(label: "done", color: MyColors.turqouise),
    ]);
  }

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0, // elimină sombra material
        insetPadding: EdgeInsets.zero,
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
                                  onPressed: () async {
                                    try {
                                      await updateTaskStatus(
                                          taskId, button.label);
                                      if (onStatusChanged != null) {
                                        onStatusChanged();
                                      }
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content:
                                            Text('Failed to update task: $e'),
                                      ));
                                    }
                                  },
                                  child: Text(
                                    formatLabel(button.label),
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
