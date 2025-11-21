import 'package:flutter/material.dart';

// IMPORTA AS SECÇÕES
import 'sections/couple_profile_chart.dart';
import 'sections/couple_profile_achivements.dart';
import 'sections/couple_profile_info.dart';
import 'package:bondedapp/bondie/pages/stats/bondie_stats_controller.dart';

class CoupleProfilePage extends StatelessWidget {
  final BondieStatsController controller; // ⭐ RECEBE O CONTROLLER VERDADEIRO

  const CoupleProfilePage({
    super.key,
    required this.controller, // ⭐ OBRIGATÓRIO
  });

  // Dummy History Data (para o gráfico — não relacionado ao controller)
  final List<double> bondHistory = const [0.82, 0.80, 0.85, 0.83, 0.87, 0.88, 0.90];
  final List<double> energyHistory = const [0.60, 0.58, 0.65, 0.62, 0.61, 0.67, 0.70];
  final List<double> moodHistory = const [0.75, 0.78, 0.77, 0.80, 0.82, 0.79, 0.85];

  // Achievements
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

      body: Stack(
        children: [
          _buildBackground(),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              physics: const BouncingScrollPhysics(),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),

                  _buildHeader(context),

                  // ============================
                  // INFO COMPLETA
                  // ============================
                  CoupleProfileInfo(
                    controller: controller, // ⭐ PASSA O CONTROLLER REAL
                    relationshipStartDate: DateTime(2023, 11, 15),
                    tripsTogether: 2,
                    songTitle: "Kiss of Life",
                    songArtist: "Sade",
                    albumCover: "assets/images/couple_album.jpg",
                  ),

                  const SizedBox(height: 30),

                  // ==== GRÁFICO ====
                  _sectionTitle("Bond Graph"),
                  const SizedBox(height: 14),
                  CoupleProfileChart(
                    bondWeeks: [bondHistory, bondHistory, bondHistory],
                    energyWeeks: [energyHistory, energyHistory, energyHistory],
                    moodWeeks: [moodHistory, moodHistory, moodHistory],
                  ),

                  const SizedBox(height: 30),

                  // ==== ACHIEVEMENTS ====
                  _sectionTitle("Achievements"),
                  const SizedBox(height: 18),
                  CoupleProfileAchievements(achievements: achievements),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // HEADER
  // -------------------------------------------------------------------------
  Widget _buildHeader(BuildContext context) {
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

  // -------------------------------------------------------------------------
  // SECTION TITLE
  // -------------------------------------------------------------------------
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
    );
  }

  // -------------------------------------------------------------------------
  // BACKGROUND (HEARTS)
  // -------------------------------------------------------------------------
  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF8FAFF), Color(0xFFE9F1FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        Positioned(top: -45, left: -40, child: _heart(180, Colors.blueAccent.withOpacity(0.08))),
        Positioned(top: 140, left: -60, child: _heart(250, Colors.blueAccent.withOpacity(0.08))),
        Positioned(top: 60, right: 0, child: _heart(170, Colors.lightBlue.withOpacity(0.08))),
        Positioned(top: 200, left: 220, child: _heart(50, Colors.blue.withOpacity(0.08))),
        Positioned(top: 300, left: 180, child: _heart(90, Colors.blue.withOpacity(0.08))),
        Positioned(top: 420, left: 30, child: _heart(120, Colors.blueAccent.withOpacity(0.08))),
        Positioned(bottom: 145, right: -50, child: _heart(220, Colors.lightBlue.withOpacity(0.08))),
        Positioned(top: 220, right: -80, child: _heart(160, Colors.indigoAccent.withOpacity(0.08))),
        Positioned(bottom: -50, left: -50, child: _heart(200, Colors.lightBlue.withOpacity(0.08))),
        Positioned(bottom: 150, left: 140, child: _heart(70, Colors.indigoAccent.withOpacity(0.08))),
        Positioned(bottom: -150, right: -50, child: _heart(270, Colors.blueAccent.withOpacity(0.08))),
      ],
    );
  }

  // ❤️ Custom Heart
  static Widget _heart(double size, Color color) =>
      CustomPaint(size: Size(size, size), painter: _HeartPainter(color));
}

// =====================================
// HEART PAINTER
// =====================================
class _HeartPainter extends CustomPainter {
  final Color color;
  _HeartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(w / 2, h * 0.75)
      ..cubicTo(-w * 0.2, h * 0.35, w * 0.25, -h * 0.2, w / 2, h * 0.25)
      ..cubicTo(w * 0.75, -h * 0.2, w * 1.2, h * 0.35, w / 2, h * 0.75)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
