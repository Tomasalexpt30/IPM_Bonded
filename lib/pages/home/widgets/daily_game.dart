import 'package:bondedapp/bondie/pages/stats/bondie_stats_controller.dart';
import 'package:bondedapp/pages/mood_quest/mood_quest_page.dart';
import 'package:flutter/material.dart';
import '../../activitys/game/activity_game.dart';

class DailyGameCard extends StatelessWidget {
  final BondieStatsController controller;

  const DailyGameCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ActivityGamePage(),
          ),
        );
      },

      child: Container(
        width: double.infinity,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: const Color(0xFFECE4FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.sports_esports_rounded,
                size: 30,
                color: Color(0xFF7B4CFF),
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Daily Game",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "\"Who is more capable of...\"",
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.35,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

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
