import 'package:bondedapp/pages/activitys/question/activity_question.dart';
import 'package:flutter/material.dart';
import '../../activitys/game/activity_game.dart'; // IMPORTA A PÁGINA DO JOGO

class DailyActivityCard extends StatelessWidget {
  const DailyActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ActivityGamePage()),
        );
      },

      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFDBEAFE), Color(0xFF96D5FD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.35),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),

        child: Stack(
          children: [
            // 🎮 Ícone no canto superior direito
            const Positioned(
              top: 0,
              right: 0,
              child: Icon(
                Icons.sports_esports_rounded,
                size: 30,
                color: Color(0xFF1E1E30),
              ),
            ),

            // ⭐ Conteúdo principal
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    SizedBox(width: 8),
                    Text(
                      "Daily Activity",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // 🔥 Título do jogo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Flexible(
                      child: Text(
                        "\"Who is more capable of...\"",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.4,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
