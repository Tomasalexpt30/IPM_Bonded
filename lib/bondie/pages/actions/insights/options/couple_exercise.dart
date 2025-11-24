import 'package:flutter/material.dart';

class CoupleExerciseOption {
  static const List<String> exercises = [
    "Share one small win from today.",
    "Tell each other one tiny wish for tomorrow.",
    "Finish the sentence: “I appreciate you because…”",
    "Look at each other and smile for five seconds.",
    "Share one thing that made you think of your partner recently.",
    "Tell your partner something you’re looking forward to together.",
  ];

  static void show(BuildContext context) {
    final String randomExercise = (List<String>.from(exercises)..shuffle()).first;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.40,
          minChildSize: 0.30,
          maxChildSize: 0.90,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 26),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),

                  const Text(
                    "Quick Couple Exercise",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "A tiny moment to reconnect together:",
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Colors.black54,
                      height: 1.35,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Bondie + bubble
                  SingleChildScrollView(
                    controller: scrollController,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4, right: 12),
                          child: Image.asset(
                            "assets/images/bondie_icons/bondie_talking.png",
                            height: 70,
                          ),
                        ),

                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCEBFF),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFB7D1F1),
                                width: 1.4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              randomExercise,
                              style: const TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
