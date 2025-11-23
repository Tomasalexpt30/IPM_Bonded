import 'package:flutter/material.dart';

class CoupleProfileAchievements extends StatelessWidget {
  final List<Map<String, dynamic>> achievements;

  const CoupleProfileAchievements({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: achievements.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 14,
        mainAxisSpacing: 16,
        childAspectRatio: 0.88,
      ),
      itemBuilder: (context, i) {
        final item = achievements[i];
        return _achievementItem(
          icon: item["icon"],
          progress: item["progress"],
          title: item["title"],
        );
      },
    );
  }

  Widget _achievementItem({
    required IconData icon,
    required double progress,
    required String title,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 62,
            width: 62,
            child: CustomPaint(
              painter: _CircularProgressPainter(progress: progress, color: const Color(0xFF2563EB)),
              child: Center(child: Icon(icon, size: 28, color: const Color(0xFF2563EB))),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, height: 1.2),
          ),
        ],
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  _CircularProgressPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 7.0;
    final center = size.center(Offset.zero);
    final radius = (size.width / 2) - (strokeWidth / 2);

    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, bgPaint);

    final fgPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const startAngle = -3.14 / 2;
    final sweepAngle = 3.14 * 2 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_) => true;
}
