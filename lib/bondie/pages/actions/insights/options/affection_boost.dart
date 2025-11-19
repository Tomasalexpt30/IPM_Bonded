import 'package:flutter/material.dart';

class AffectionBoostOption {
  static const List<String> boosts = [
    "Give your partner a warm hug that lasts a little longer than usual.",
    "Say one sweet thing you love about your partner, even if it’s something small.",
    "Send a short voice message telling your partner you’re thinking about them.",
    "Hold your partner’s hand for a moment today, even if you're just passing by.",
    "Give your partner a soft smile the next time they look at you.",
    "Compliment something they’ve done recently that you genuinely noticed.",
    "Leave a cute message somewhere they will find it later.",
    "Gently touch their shoulder, hair, or back as a sign of affection.",
    "Share a small memory that still warms your heart.",
    "Tell them something you adore about their personality.",
  ];

  static void show(BuildContext context) {
    final String randomBoost = (List<String>.from(boosts)..shuffle()).first;

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
                  // Grabber
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

                  // Title
                  const Text(
                    "Affection Boost",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "A small gesture to bring a little extra warmth today:",
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
                        // Bondie icon
                        Padding(
                          padding: const EdgeInsets.only(top: 4, right: 12),
                          child: Image.asset(
                            "assets/images/bondie_icons/bondie_talking.png",
                            height: 70,
                          ),
                        ),

                        // Speech bubble
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
                              randomBoost,
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
