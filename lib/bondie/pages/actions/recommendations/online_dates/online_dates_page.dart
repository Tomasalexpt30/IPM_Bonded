import 'package:flutter/material.dart';
import '../../../../widget/animated_bondie_widget.dart';
import '../../../stats/bondie_stats_controller.dart';
import '../../../../../main.dart';
import 'package:bondedapp/layout/app_background.dart';

class OnlineDatesPage extends StatelessWidget {
  final BondieStatsController controller;

  const OnlineDatesPage({super.key, required this.controller});

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
                              child: Icon(Icons.arrow_back_rounded,
                                  size: 26, color: Colors.black87),
                            ),
                          ),
                        ),
                        const Text(
                          "Online Dates",
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

                  _buildCard(
                    icon: Icons.movie_filter_rounded,
                    title: "Virtual Movie Night",
                    description: "Watch a film together using screen share or a synced streaming app.",
                    color: const Color(0xFF77B8F5),
                  ),
                  const SizedBox(height: 20),

                  _buildCard(
                    icon: Icons.videogame_asset_rounded,
                    title: "Online Games",
                    description: "Play fun co-op games or compete for bragging rights.",
                    color: const Color(0xFFA47DF6),
                  ),
                  const SizedBox(height: 20),

                  _buildCard(
                    icon: Icons.dinner_dining_rounded,
                    title: "Digital Dinner",
                    description: "Cook the same meal together on video call and enjoy it as a date.",
                    color: const Color(0xFFF6A67A),
                  ),
                  const SizedBox(height: 20),

                  _buildCard(
                    icon: Icons.emoji_emotions_rounded,
                    title: "Cozy Call Night",
                    description: "Just talk, laugh and share your day with a warm drink in hand.",
                    color: const Color(0xFFF69AB2),
                  ),
                  const SizedBox(height: 20),

                  _buildCard(
                    icon: Icons.explore_rounded,
                    title: "Virtual Museum Tour",
                    description: "Explore art and culture together from anywhere.",
                    color: const Color(0xFF64D4A7),
                  ),
                  const SizedBox(height: 20),

                  _buildCard(
                    icon: Icons.music_note_rounded,
                    title: "Shared Playlist Night",
                    description: "Create a playlist together and enjoy music while chatting.",
                    color: const Color(0xFF7EC8E3),
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
