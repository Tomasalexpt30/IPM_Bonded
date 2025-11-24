import 'package:flutter/material.dart';
import '../../../../../widget/animated_bondie_widget.dart';
import '../../../../stats/bondie_stats_controller.dart';
import '../../../../../../main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bondedapp/layout/app_background.dart';

class EscapeRoomPage extends StatelessWidget {
  final BondieStatsController controller;

  const EscapeRoomPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      bottomNavigationBar: _buildBottomBar(context),

      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              size: 26,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        const Text(
                          "Escape Room",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 26),

                  _mainInfoBlock(context),
                  const SizedBox(height: 26),

                  _bondieWhySection(),
                  const SizedBox(height: 26),

                  _tipsSection(),
                  const SizedBox(height: 26),

                  _smallInfoRow(),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mainInfoBlock(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              height: 150,
              width: double.infinity,
              color: Colors.white,
              child: Image.asset(
                "assets/images/recommendations/game_over_logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 0),

          const Text(
            "Escape Rooms are thrilling and fun date activities where you solve puzzles, "
                "follow clues, and escape before time runs out. It’s teamwork and excitement in one!\n\n"
                "We recommend the Escape Rooms from GAME OVER — they’re known for great themes "
                "and high-quality immersive experiences.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(
                child: _iconButton(
                  icon: Icons.link_rounded,
                  label: "Website",
                  color: const Color(0xFF2563EB),
                  onTap: () => launchUrl(
                    Uri.parse("https://escaperoom.pt/"),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _iconButton(
                  icon: Icons.location_on_rounded,
                  label: "Location",
                  color: const Color(0xFF2563EB),
                  onTap: () => launchUrl(
                    Uri.parse("https://maps.google.com/?q=escape+room+lisboa"),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tipsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.lightbulb_rounded, color: Color(0xFF2563EB)),
              SizedBox(width: 8),
              Text(
                "Tips to Boost the Experience",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _tipCard(
            number: "1",
            title: "Communicate clearly",
            subtitle: "Share every clue you notice — teamwork is key!",
          ),
          const SizedBox(height: 10),

          _tipCard(
            number: "2",
            title: "Divide and conquer",
            subtitle: "Split tasks to solve puzzles faster.",
          ),
          const SizedBox(height: 10),

          _tipCard(
            number: "3",
            title: "Don't panic",
            subtitle: "Stay calm and enjoy the challenge — it's meant to be fun.",
          ),
        ],
      ),
    );
  }

  Widget _tipCard({
    required String number,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
              height: 1,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bondieWhySection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: Image.asset("assets/images/bondie_icons/bondie_talking.png"),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Text(
              "Escape Rooms are great for connection!"
                  " You must collaborate, solve problems together,"
                  " and trust each other under pressure."
                  " It strengthens communication — and it's incredibly fun!",
              style: TextStyle(
                fontSize: 14,
                height: 1.45,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _smallInfoRow() {
    return Row(
      children: [
        Expanded(
          child: _smallSquare(Icons.schedule_rounded, "Duration", "60m"),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _smallSquare(Icons.euro_rounded, "Price", "18–30€"),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _smallSquare(Icons.lock_clock_rounded, "Difficulty", "Medium"),
        ),
      ],
    );
  }

  Widget _smallSquare(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: const Color(0xFF2563EB)),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.grey[700],
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
    );
  }
}
