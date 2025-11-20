import 'package:flutter/material.dart';
import '../../../bondie/pages/stats/bondie_stats_controller.dart';

import 'widgets/couple_section.dart';
import 'widgets/daily_activity.dart';
import 'widgets/time_capsule.dart';
import 'widgets/weekly_challenge.dart';

class HomePage extends StatelessWidget {
  final BondieStatsController bondieStats;

  const HomePage({
    super.key,
    required this.bondieStats,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: Stack(
        children: [
          // Fundo suave + corações
          _buildBackground(),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título da página
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    // 💞 Couple section — AGORA COM CONTROLLER
                    CoupleSection(controller: bondieStats),
                    const SizedBox(height: 35),

                    // 🌤️ Daily activity
                    const DailyActivityCard(),
                    const SizedBox(height: 35),

                    // 🕒 Time Capsule
                    const TimeCapsuleCard(),
                    const SizedBox(height: 35),

                    // 🏆 Weekly Challenge — aparece só ao fazer scroll
                    const WeeklyChallengeCard(),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================
  // BACKGROUND + CORAÇÕES
  // ===============================
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

        // 💙 Corações decorativos
        Positioned(
          top: -45,
          left: -40,
          child: _heart(180, Colors.blueAccent.withOpacity(0.08)),
        ),
        Positioned(
          top: 140,
          left: -60,
          child: _heart(250, Colors.blueAccent.withOpacity(0.08)),
        ),
        Positioned(
          top: 60,
          right: 0,
          child: _heart(170, Colors.lightBlue.withOpacity(0.08)),
        ),
        Positioned(
          top: 200,
          left: 220,
          child: _heart(50, Colors.blue.withOpacity(0.08)),
        ),
        Positioned(
          top: 300,
          left: 180,
          child: _heart(90, Colors.blue.withOpacity(0.08)),
        ),
        Positioned(
          top: 420,
          left: 30,
          child: _heart(120, Colors.blueAccent.withOpacity(0.08)),
        ),
        Positioned(
          bottom: 145,
          right: -50,
          child: _heart(220, Colors.lightBlue.withOpacity(0.08)),
        ),
        Positioned(
          top: 220,
          right: -80,
          child: _heart(160, Colors.indigoAccent.withOpacity(0.08)),
        ),
        Positioned(
          bottom: -50,
          left: -50,
          child: _heart(200, Colors.lightBlue.withOpacity(0.08)),
        ),
        Positioned(
          bottom: 150,
          left: 140,
          child: _heart(70, Colors.indigoAccent.withOpacity(0.08)),
        ),
        Positioned(
          bottom: -150,
          right: -50,
          child: _heart(270, Colors.blueAccent.withOpacity(0.08)),
        ),
      ],
    );
  }

  // ❤️ Função para desenhar corações
  static Widget _heart(double size, Color color) => CustomPaint(
    size: Size(size, size),
    painter: _HeartPainter(color),
  );
}

// =====================================
// 💙 Heart Painter (para o fundo)
// =====================================
class _HeartPainter extends CustomPainter {
  final Color color;
  _HeartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Desenha um coração simétrico
    path.moveTo(w / 2, h * 0.75);
    path.cubicTo(-w * 0.2, h * 0.35, w * 0.25, -h * 0.2, w / 2, h * 0.25);
    path.cubicTo(w * 0.75, -h * 0.2, w * 1.2, h * 0.35, w / 2, h * 0.75);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
