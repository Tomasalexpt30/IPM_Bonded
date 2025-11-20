import 'package:flutter/material.dart';
import 'bondie_stats_controller.dart';

class BondieStats extends StatelessWidget {
  final Animation<double> floatAnimation;
  final BondieStatsController controller;

  const BondieStats({
    super.key,
    required this.floatAnimation,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Floating Bondie
        AnimatedBuilder(
          animation: floatAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, floatAnimation.value),
              child: child,
            );
          },
          child: Image.asset(
            controller.bondieImage,
            height: 180,
          ),
        ),

        const SizedBox(height: 20),

        // ⭐ Mood + Age
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(controller.moodIcon, size: 22, color: controller.moodColor),
            const SizedBox(width: 6),
            Text(
              controller.moodText,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(width: 30),

            const Icon(Icons.hourglass_bottom_rounded,
                size: 20, color: Color(0xFF3B82F6)),
            const SizedBox(width: 6),
            const Text(
              "2y 3m",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),

        const SizedBox(height: 25),

        // ⭐ Circular Stats
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _CircularStat(
              label: "Connection",
              icon: Icons.link_rounded,
              iconColor: const Color(0xFF66C85B), // mint green
              value: controller.connection,
            ),
            _CircularStat(
              label: "Energy",
              icon: Icons.bolt_rounded,
              iconColor: const Color(0xFFFFB834), // yellow (same)
              value: controller.energy,
            ),
            _CircularStat(
              label: "Affection",
              icon: Icons.favorite_rounded,
              iconColor: const Color(0xFFE085B5), // warm lavender pink
              value: controller.affection,
            ),
          ],
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

// ==========================================================================
// CIRCULAR STAT
// ==========================================================================
class _CircularStat extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final double value;

  const _CircularStat({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 90,
          width: 90,
          child: CustomPaint(
            painter: _CircularStatPainter(
              value: value,
              color: iconColor,
            ),
            child: Center(
              child: Icon(icon, size: 30, color: iconColor),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          "${(value * 100).round()}%",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: iconColor,
          ),
        ),
      ],
    );
  }
}

// ==========================================================================
// PAINTER (igual ao original)
// ==========================================================================
class _CircularStatPainter extends CustomPainter {
  final double value;
  final Color color;

  _CircularStatPainter({
    required this.value,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 10.0;
    final center = size.center(Offset.zero);
    final radius = (size.width / 2) - (strokeWidth / 2);

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -3.14159 / 2;
    final sweepAngle = 3.14159 * 2 * value;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
