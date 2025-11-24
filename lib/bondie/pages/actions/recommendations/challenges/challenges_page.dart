import 'package:flutter/material.dart';
import '../../../../widget/animated_bondie_widget.dart';
import '../../../stats/bondie_stats_controller.dart';
import '../../../../../main.dart';
import 'package:bondedapp/layout/app_background.dart';

class ChallengesPage extends StatelessWidget {
  final BondieStatsController controller;

  const ChallengesPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.grey[600],
          unselectedItemColor: Colors.grey[500],
          iconSize: 30,
          selectedFontSize: 13,
          unselectedFontSize: 13,
          onTap: (index) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => MainScreenWithIndex(index: index),
              ),
                  (_) => false,
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: 'Couple',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: 'Settings',
            ),
          ],
        ),
      ),

      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 6),

                  // HEADER
                  SizedBox(
                    height: 40,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Icon(Icons.arrow_back_rounded, size: 26, color: Colors.black87),
                            ),
                          ),
                        ),
                        const Text(
                          "Challenges",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // CHALLENGE CARDS
                  _buildCard(
                    icon: Icons.restaurant_menu_rounded,
                    title: "Cook Together",
                    description: "Choose a new recipe and prepare dinner together this week.",
                    color: const Color(0xFF77B8F5),
                  ),
                  const SizedBox(height: 20),

                  _buildCard(
                    icon: Icons.favorite_rounded,
                    title: "3 Acts of Kindness",
                    description: "Each of you performs 3 small surprises for the other.",
                    color: const Color(0xFFF69AB2),
                  ),
                  const SizedBox(height: 20),

                  _buildCard(
                    icon: Icons.self_improvement_rounded,
                    title: "Mindfulness Challenge",
                    description: "Do a 10-minute relaxing session together every day.",
                    color: const Color(0xFFA37EF6),
                  ),
                  const SizedBox(height: 20),

                  _buildCard(
                    icon: Icons.photo_camera_rounded,
                    title: "Photo of the Day",
                    description: "Take a meaningful photo every day and share it nightly.",
                    color: const Color(0xFFF6A67A),
                  ),
                  const SizedBox(height: 20),

                  _buildCard(
                    icon: Icons.explore_rounded,
                    title: "Try Something New",
                    description: "Pick one new activity this week and experience it together.",
                    color: const Color(0xFF64D4A7),
                  ),
                  const SizedBox(height: 20),

                  _buildCard(
                    icon: Icons.book_rounded,
                    title: "Story Swap",
                    description: "Share a personal story the other person doesn't know yet.",
                    color: const Color(0xFF8EC6FF),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Colors.black54,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
