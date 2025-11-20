import 'package:flutter/material.dart';
import 'package:bondedapp/pages/profiles/couple/couple_profile_page.dart';
import 'package:bondedapp/bondie/pages/stats/bondie_stats_controller.dart';

class CoupleSection extends StatelessWidget {
  final BondieStatsController controller;

  const CoupleSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final double bondLevel = controller.avg; // (ainda existe mas já não é usado)

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CoupleProfilePage()),
        );
      },

      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
        child: Column(
          children: [
            const Text(
              "Bruno & Ana",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage('assets/images/user1.png'),
                ),

                Image(
                  image: AssetImage('assets/images/bonded_logo.png'),
                  height: 36,
                ),

                CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage('assets/images/user2.png'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ⭐ Aqui estava o Bond Level + Info — agora removido
            // ⭐ Aqui estava a barra de progresso — agora removida
          ],
        ),
      ),
    );
  }
}
