import 'package:flutter/material.dart';
import 'package:mindtrack/add_task.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/details_popup.dart';
import 'package:mindtrack/endpoint/gettasks.dart';
import 'package:mindtrack/models/taskmodel.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<UserTask> allTasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        setState(() {});
      }
    });
    loadTasks();
  }

  bool isFetching = false;

  Future<void> loadTasks() async {
    if (isFetching) return;
    isFetching = true;
    try {
      final tasks = await fetchUserTasks();
      setState(() {
        allTasks = tasks.whereType<UserTask>().toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      isFetching = false;
    }
  }

  List<UserTask> _filteredTasks(String status) {
    return allTasks
        .where((task) => task.status.toLowerCase() == status)
        .toList();
  }

  Widget _buildTaskCard(String taskId, String title, String label, String date,
      String tabType, String details) {
    Color backgroundColor;
    Color addColor;
    Color labelColor;

    switch (tabType) {
      case 'done':
        backgroundColor = MyColors.lightblue;
        addColor = MyColors.turqouise;
        break;
      case 'abandoned':
        backgroundColor = MyColors.turqouise;
        addColor = MyColors.lightblue;
        break;
      default:
        backgroundColor = MyColors.cream;
        addColor = MyColors.pink;
    }

    switch (label.toLowerCase()) {
      case 'low':
        labelColor = MyColors.emojigreen;
        break;
      case 'medium':
        labelColor = MyColors.emojiyellow;
        break;
      case 'high':
        labelColor = MyColors.emojired;
        break;
      case 'recommended':
        labelColor = MyColors.emojidarkblue;
        break;
      default:
        labelColor = MyColors.black;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: MyColors.black, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: labelColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: MyColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14),
                    const SizedBox(width: 4),
                    Text(date, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              showTaskOptionsPopup(
                context,
                taskId,
                title,
                details,
                tabType,
                onStatusChanged: () async {
                  await loadTasks(); // refresh tasks after status update
                },
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: addColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: MyColors.black.withOpacity(0.5),
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz, color: MyColors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(String tabType) {
    final filtered = _filteredTasks(tabType);
    if (filtered.isEmpty) {
      return const Center(child: Text("No tasks"));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 140, top: 15),
      child: Column(
        children: filtered
            .map((task) => _buildTaskCard(
                  task.id,
                  task.title,
                  task.priority,
                  task.endDate.split('T').first,
                  tabType,
                  task.details,
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              _tabController.index == 0
                  ? 'assets/icons/tasksus.png'
                  : 'assets/icons/taskrozsus.png',
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(left: 25, top: 30, right: 20, bottom: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Daily Task List",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: MyColors.darkblue,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: MyColors.lightblue, width: 2),
                      ),
                      child: IgnorePointer(
                        child: TabBar(
                          controller: _tabController,
                          labelColor: MyColors.white,
                          unselectedLabelColor: MyColors.black,
                          isScrollable: false,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: MyColors.black,
                          ),
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          tabs: const [
                            Tab(child: Center(child: Text("To Do"))),
                            Tab(child: Center(child: Text("Done"))),
                            Tab(child: Center(child: Text("Abandoned"))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : TabBarView(
                          controller: _tabController,
                          children: [
                            _buildTabContent("todo"),
                            _buildTabContent("done"),
                            _buildTabContent("abandoned"),
                          ],
                        ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: MyColors.darkblue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: MyColors.lightblue, width: 2),
              ),
              onPressed: () => showAddTaskDialog(context, loadTasks),
              child: const Icon(Icons.add, size: 32, color: MyColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
