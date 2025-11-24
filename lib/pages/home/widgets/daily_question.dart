import 'package:flutter/material.dart';
import '../../activitys/question/activity_question.dart';

class DailyQuestionCard extends StatelessWidget {
  const DailyQuestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ActivityQuestionPage()),
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
                color: const Color(0xFFE3ECFF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.question_mark_rounded,
                size: 30,
                color: Color(0xFF2563EB),
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Daily Question",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "\"What is one small thing you could do today to make your partner feel appreciated?\"",
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
