import 'package:flutter/material.dart';
import 'package:mindtrack/constant/constant.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  final List<Map<String, String>> mockArticles = const [
    {
      'title': 'Understanding Anxiety',
      'image': 'assets/icons/articole1.png',
    },
    {
      'title': 'Dealing with Depression',
      'image': 'assets/icons/articole1.png',
    },
    {
      'title': 'Daily Mindfulness Tips',
      'image': 'assets/icons/articole1.png',
    },
    {
      'title': 'Men\'s Mental Health',
      'image': 'assets/icons/articole1.png',
    },
    {
      'title': 'Overcoming Burnout',
      'image': 'assets/icons/articole1.png',
    },
    {
      'title': 'Overcoming Burnout',
      'image': 'assets/icons/articole1.png',
    },
    {
      'title': 'Overcoming Burnout',
      'image': 'assets/icons/articole1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.turqouise,
      body: Stack(
        children: [
          // Top wave image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/icons/article_sus.png'),
          ),

          // Bottom wave image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/icons/article_jos.png'),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section title box
                  Center(
                    child: Container(
                      width: 260,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: MyColors.pink,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Mental Health Articles',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter-VariableFont_opsz,wght',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Article list
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: mockArticles.length,
                    separatorBuilder: (_, __) => const Column(
                      children: [
                        SizedBox(height: 16),
                        Divider(color: Colors.black),
                        SizedBox(height: 16),
                      ],
                    ),
                    itemBuilder: (context, index) {
                      final article = mockArticles[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Article title
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Text(
                                article['title'] ?? 'Titlu articol',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter-VariableFont_opsz,wght',
                                ),
                              ),
                            ),
                          ),

                          // Article image
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: MyColors.lightblue,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(9),
                              child: Image.asset(
                                article['image']!,
                                width: 130,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
