import 'package:flutter/material.dart';
import 'package:bondedapp/bondie/pages/stats/bondie_stats_controller.dart';

class CoupleSection extends StatelessWidget {
  final BondieStatsController controller;

  const CoupleSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Informação da memória (podes mudar quando quiseres)
    const String memoryDate = "12 Feb 2024";
    const String memoryLocation = "Lisbon, Portugal";

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.18),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ======================================================
          // HEADER — MEMORY OF THE DAY + ÍCONE
          // ======================================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Memory of the Day",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),

              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F5FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.photo_library_rounded,
                  size: 20,
                  color: Color(0xFF4E8EF6),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // ======================================================
          // FOTO DO CASAL — MEMÓRIA
          // ======================================================
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                "assets/images/couple_selfie.png",
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: const Alignment(0, -0.55),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // ======================================================
          // DATE + LOCATION (CENTRADOS)
          // ======================================================
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.calendar_today_rounded,
                  size: 18, color: Color(0xFF4E8EF6)),
              SizedBox(width: 6),
              Text(
                memoryDate,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              SizedBox(width: 12),


              Icon(Icons.location_on_rounded,
                  size: 18, color: Color(0xFF4E8EF6)),
              SizedBox(width: 6),
              Text(
                memoryLocation,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ======================================================
          // PERSONAL COMMENT FROM ANA — "CHAT BUBBLE"
          // ======================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar da Ana
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/images/user2.png"),
              ),

              const SizedBox(width: 10),

              // Caixa da frase
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF2FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    "Sometimes I look back at this moment and realise how lucky we are.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.45,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
