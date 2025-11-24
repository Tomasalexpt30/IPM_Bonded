import 'package:flutter/material.dart';

class BondieStatsController {
  double connection;
  double energy;
  double affection;

  BondieStatsController({
    this.connection = 0.8,
    this.energy = 0.8,
    this.affection = 0.8,
  });

  void updateStats({
    double? connection,
    double? energy,
    double? affection,
  }) {
    if (connection != null) this.connection = connection;
    if (energy != null) this.energy = energy;
    if (affection != null) this.affection = affection;
  }

  double get avg => (connection + energy + affection) / 3;

  String get bondieImage {
    if (energy == 0) return "assets/images/bondie_icons/bondie_ghost.png";
    if (avg >= 0.80) return "assets/images/bondie_icons/bondie_super_happy.png";
    if (avg >= 0.50) return "assets/images/bondie_icons/bondie_happy.png";
    if (avg >= 0.20) return "assets/images/bondie_icons/bondie_sad.png";
    return "assets/images/bondie_icons/bondie_depressed.png";
  }

  String get moodText {
    if (energy == 0) return "Ghost";
    if (avg >= 0.80) return "Super Happy";
    if (avg >= 0.50) return "Happy";
    if (avg >= 0.20) return "Low Mood";
    return "Depressed";
  }

  IconData get moodIcon {
    if (energy == 0) return Icons.stars_outlined;
    if (avg >= 0.80) return Icons.celebration_rounded;
    if (avg >= 0.60) return Icons.mood_rounded;
    if (avg >= 0.40) return Icons.sentiment_dissatisfied_rounded;
    return Icons.sentiment_very_dissatisfied_rounded;
  }

  Color get moodColor {
    if (energy == 0) return const Color(0xFF8C4AD3);
    if (avg >= 0.85) return Colors.orangeAccent;
    if (avg >= 0.60) return Colors.orange;
    if (avg >= 0.40) return const Color(0xFF2F8DCB);
    return Colors.grey;
  }
}
