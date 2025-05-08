import 'package:flutter/material.dart';
import 'package:mindtrack/constant/constant.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTaskCard(String title, String label, Color color, String date) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.cream,
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
                      color: color, borderRadius: BorderRadius.circular(12)),
                  child: Text(label,
                      style: const TextStyle(
                          fontSize: 12,
                          color: MyColors.black,
                          fontWeight: FontWeight.w500)),
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
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: MyColors.pink,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.black.withOpacity(0.5),
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: MyColors.black),
            ],
          ),
        ],
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
              child: Image.asset('assets/icons/tasksus.png'),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset('assets/icons/taskjos.png'),
            ),
            SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 25, top: 30, right: 20, bottom: 15),
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
                          border: Border.all(
                            color: MyColors.lightblue,
                            width: 2,
                          ),
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
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 140, top: 15),
                          child: Column(
                            children: [
                              _buildTaskCard("School Project", "High",
                                  MyColors.emojired, "28 Dec. 2024"),
                              _buildTaskCard("Nature Walk", "Recommended",
                                  MyColors.emojidarkblue, "27 Dec. 2024"),
                              _buildTaskCard(
                                  "Creative Activities",
                                  "Recommended",
                                  MyColors.emojidarkblue,
                                  "25 Dec. 2024"),
                              _buildTaskCard("Gym", "Medium",
                                  MyColors.emojiyellow, "28 Nov. 2024"),
                              _buildTaskCard("Gym", "Medium",
                                  MyColors.emojiyellow, "28 Nov. 2024"),
                              _buildTaskCard("Gym", "Medium",
                                  MyColors.emojiyellow, "28 Nov. 2024"),
                            ],
                          ),
                        ),
                        const Center(child: Text("Done tasks")),
                        const Center(child: Text("Abandoned tasks")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 90,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: MyColors.darkblue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: MyColors.lightblue, width: 2),
                ),
                onPressed: () {},
                child: const Icon(Icons.add, size: 32, color: MyColors.black),
              ),
            ),
          ],
        ));
  }
}
