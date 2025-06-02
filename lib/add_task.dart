import 'package:flutter/material.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/endpoint/addtask.dart';
import 'package:mindtrack/models/usertaskdto.dart';

void showAddTaskDialog(BuildContext context, VoidCallback onTaskAdded) {
  String selectedPriority = '';
  DateTime selectedDate = DateTime.now();
  final titleController = TextEditingController();
  final detailsController = TextEditingController();

  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => Stack(
      children: [
        GestureDetector(
          onTap: () => entry.remove(),
          child: Container(color: Colors.black.withOpacity(0.5)),
        ),
        Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 305,
              height: 655,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MyColors.pink,
                borderRadius: BorderRadius.circular(30),
              ),
              child: StatefulBuilder(
                builder: (context, setState) {
                  Widget priorityButton(String label, Color color) {
                    final isSelected = selectedPriority == label;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPriority = label;
                        });
                        print("Selected priority: $label");
                      },
                      child: Container(
                        width: 90,
                        height: 35,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? color : color.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: MyColors.black,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Text(
                          label,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: MyColors.black),
                        ),
                      ),
                    );
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Add a Task",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 16),

                      // Add Title
                      Container(
                        height: 50,
                        width: 275,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: MyColors.grey,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                  hintText: 'Add Title',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Image.asset(
                              'assets/icons/pencil.png',
                              width: 20,
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Add Details
                      Container(
                        height: 100,
                        width: 275,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: MyColors.grey,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: detailsController,
                                maxLines: 4,
                                decoration: const InputDecoration(
                                  hintText: 'Add Task Details',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image.asset(
                                'assets/icons/pencil.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Choose Priority
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Choose Priority",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  priorityButton("High", MyColors.emojired),
                                  priorityButton(
                                      "Medium", MyColors.emojiyellow),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  priorityButton("Low", MyColors.emojigreen),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Calendar
                      Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: MyColors.darkblue,
                            onPrimary: MyColors.white,
                            onSurface: MyColors.black,
                          ),
                        ),
                        child: SizedBox(
                          height: 200,
                          child: CalendarDatePicker(
                            initialDate: selectedDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                            onDateChanged: (date) {
                              setState(() {
                                selectedDate = date;
                              });
                              print("Selected date: $date");
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 35,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.cream,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => entry.remove(),
                              child: const Text("Cancel",
                                  style: TextStyle(
                                      color: MyColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            height: 35,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.turqouise,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () async {
                                final title = titleController.text;
                                final details = detailsController.text;

                                if (title.isEmpty ||
                                    details.isEmpty ||
                                    selectedPriority.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Please complete all fields")),
                                  );
                                  return;
                                }

                                final task = UserTaskDTO(
                                  userId: '',
                                  title: title,
                                  details: details,
                                  priority: selectedPriority,
                                  status: 'todo',
                                  endDate: selectedDate,
                                );

                                await submitUserTask(task);
                                onTaskAdded();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Task created")),
                                );
                                entry.remove();
                              },
                              child: const Text("Done",
                                  style: TextStyle(
                                      color: MyColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );

  overlay.insert(entry);
}
