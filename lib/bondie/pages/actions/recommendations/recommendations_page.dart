import 'package:flutter/material.dart';
import 'package:bondedapp/layout/app_background.dart';
import '../../../../main.dart';
import '../../stats/bondie_stats_controller.dart';

// IMPORTA AS NOVAS PÁGINAS
import 'real_world_dates/real_world_dates_page.dart';
import 'online_dates/online_dates_page.dart';
import 'challenges/challenges_page.dart';
import 'gift_ideas/gift_ideas_page.dart';

class RecommendationsPage extends StatelessWidget {
  final BondieStatsController controller;

  const RecommendationsPage({
    super.key,
    required this.controller,
  });

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
                  const SizedBox(height: 5),

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
                              child: Icon(
                                Icons.arrow_back_rounded,
                                size: 26,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          "Recommendations",
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

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 38,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.12),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/bondie_icons/bondie_talking.png",
                          height: 100,
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Personalized Ideas for You",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Bondie picked the best activities, dates and challenges "
                                    "to bring you closer together.",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 17),

                  _buildCategory(
                    context,
                    icon: Icons.favorite_rounded,
                    title: "Real-World Dates",
                    description: "Romantic experiences in person.",
                    color: const Color(0xFF7AB6F6),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              RealWorldDatesPage(controller: controller),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  _buildCategory(
                    context,
                    icon: Icons.monitor_heart_rounded,
                    title: "Online Dates",
                    description: "Cozy virtual plans for any couple.",
                    color: const Color(0xFFA17BF6),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              OnlineDatesPage(controller: controller),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  _buildCategory(
                    context,
                    icon: Icons.bolt_rounded,
                    title: "Challenges",
                    description: "Fun weekly tasks chosen by Bondie.",
                    color: const Color(0xFFF69AB4),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ChallengesPage(controller: controller),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  _buildCategory(
                    context,
                    icon: Icons.card_giftcard_rounded,
                    title: "Gift Ideas",
                    description: "Special little surprises.",
                    color: const Color(0xFF5EC8A7),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              GiftIdeasPage(controller: controller),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
        required Color color,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }
}
