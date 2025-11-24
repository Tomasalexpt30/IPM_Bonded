import 'package:flutter/material.dart';

class MoodQuestIntroPage extends StatelessWidget {
  const MoodQuestIntroPage({super.key, required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          child: Column(
            children: [

              // TOP BAR
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_rounded,
                        size: 26, color: Colors.black87),
                  ),
                  const Spacer(),
                ],
              ),

              const SizedBox(height: 40),

              // MAIN BONDIE + CHAT BUBBLE
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === BONDIE TALKING (não o happy) ===
                  SizedBox(
                    width: 90,
                    child: Image.asset(
                      "assets/images/bondie_icons/bondie_talking.png",
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(width: 10),

                  // SPEECH BUBBLE
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Bondie asks...",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "How is your relationship feeling today?\nLet’s do your Mood Quest!",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.45,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 80),

              // SMALL DESCRIPTION
              const Text(
                "You'll answer 3 short fun questions.\nIt only takes a few seconds!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.45,
                  color: Colors.black54,
                ),
              ),

              const Spacer(),

              // START BUTTON
              GestureDetector(
                onTap: onStart,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Start Mood Quest",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
