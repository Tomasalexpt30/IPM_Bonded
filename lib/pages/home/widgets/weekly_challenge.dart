import 'package:flutter/material.dart';

class WeeklyChallengeCard extends StatelessWidget {
  const WeeklyChallengeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFE9EBFD),
            Color(0xFFB9A7FB),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 22),

      child: Stack(
        children: [
          // -----------------------------------------
          // 🏆 TROPHY ICON (top-right)
          // -----------------------------------------
          const Positioned(
            top: 0,
            right: 0,
            child: Icon(
              Icons.emoji_events_rounded,
              size: 30,
              color: Color(0xFF1E1E30),
            ),
          ),

          // -----------------------------------------
          // 🔹 MAIN CONTENT
          // -----------------------------------------
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 TITLE — ALIGNED WITH DAILY
              const Row(
                children: [
                  SizedBox(width: 8), // 👈 ADDED FOR PERFECT ALIGNMENT
                  Text(
                    "Weekly Challenge",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 🔹 Mission title + description with vertical bar
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vertical decorative bar
                  Container(
                    width: 4,
                    height: 78,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF5AB5F1),
                          Color(0xFF2F8DCB),
                          Color(0xFF1E7AB3),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Text column
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔹 Mission Title
                        Text(
                          "Sweet Surprise Challenge",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E1E30),
                          ),
                        ),

                        SizedBox(height: 6),

                        // 🔹 Mission Description (italic)
                        Text(
                          "\"Because when life has its own sweet taste, it tastes even better shared.\" \n",
                          style: TextStyle(
                            fontSize: 15.5,
                            height: 1.5,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 0),

              // 🌟 PROGRESS BAR
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Completed: 50%",
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 9,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.35),
                      ),
                      child: Stack(
                        children: [
                          FractionallySizedBox(
                            widthFactor: 0.5, // 50%
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF93C9FA),
                                    Color(0xFF5AB5F1),
                                    Color(0xFF2F8DCB),
                                    Color(0xFF1E7AB3),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.4),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
