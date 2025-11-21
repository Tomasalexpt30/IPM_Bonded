import 'package:flutter/material.dart';
import 'package:bondedapp/layout/app_background.dart';

// IMPORTA AS SECÇÕES
import 'sections/couple_profile_chart.dart';
import 'sections/couple_profile_achivements.dart';
import 'sections/couple_profile_info.dart';
import 'package:bondedapp/bondie/pages/stats/bondie_stats_controller.dart';

class CoupleProfilePage extends StatelessWidget {
  final BondieStatsController controller;

  const CoupleProfilePage({
    super.key,
    required this.controller,
  });

  // Dummy History Data
  final List<double> bondHistory = const [0.82, 0.80, 0.85, 0.83, 0.87, 0.88, 0.90];
  final List<double> energyHistory = const [0.60, 0.58, 0.65, 0.62, 0.61, 0.67, 0.70];
  final List<double> moodHistory = const [0.75, 0.78, 0.77, 0.80, 0.82, 0.79, 0.85];

  final List<Map<String, dynamic>> achievements = const [
    {"title": "First Week", "icon": Icons.calendar_month_rounded, "progress": 1.0},
    {"title": "Captured Moments", "icon": Icons.camera_alt_rounded, "progress": 0.80},
    {"title": "Challenges", "icon": Icons.extension_rounded, "progress": 0.20},
    {"title": "Gifts", "icon": Icons.card_giftcard_rounded, "progress": 0.40},
    {"title": "Playlist", "icon": Icons.music_note_rounded, "progress": 0.60},
    {"title": "Adventures", "icon": Icons.explore_rounded, "progress": 0.33},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),

                _buildHeader(),

                // INFO
                CoupleProfileInfo(
                  controller: controller,
                  relationshipStartDate: DateTime(2023, 11, 15),
                  tripsTogether: 2,
                  songTitle: "Kiss of Life",
                  songArtist: "Sade",
                  albumCover: "assets/images/couple_album.jpg",
                ),

                const SizedBox(height: 30),

                // GRAPH
                _sectionTitle("Bond Graph"),
                const SizedBox(height: 14),
                CoupleProfileChart(
                  bondWeeks: [bondHistory, bondHistory, bondHistory],
                  energyWeeks: [energyHistory, energyHistory, energyHistory],
                  moodWeeks: [moodHistory, moodHistory, moodHistory],
                ),

                const SizedBox(height: 30),

                // ACHIEVEMENTS
                _sectionTitle("Achievements"),
                const SizedBox(height: 18),
                CoupleProfileAchievements(achievements: achievements),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // HEADER --------------------------------------------------------
  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.only(top: 12, bottom: 30),
      child: Text(
        "Couple Profile",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // SECTION TITLE -------------------------------------------------
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }
}
