import 'package:flutter/material.dart';

class TipOfTheDayOption {
  // -------- NOVAS DICAS --------
  static const List<String> tips = [
    "End the day by sharing one thing that made you smile.",
    "Do a small act of kindness today without mentioning it.",
    "Share a simple plan or idea you want to try together soon.",
    "Thank your partner for something they do regularly but rarely get credit for.",
    "Choose one tiny task and make it easier for your partner today.",
    "Give each other two minutes of full attention with no phones.",
    "Bring up a small moment you enjoyed together this week.",
    "Ask your partner what they need more of today.",
    "Leave a short positive note somewhere your partner will find it.",
    "Take a moment to appreciate something about your partner silently, then say it out loud.",
  ];


  static void show(BuildContext context) {
    final String randomTip = (List<String>.from(tips)..shuffle()).first;

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
                    "Tip of the Day",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "A small suggestion from Bondie to make today feel a little more connected:",
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Colors.black54,
                      height: 1.35,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Flexible(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bondie ao lado
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
                                randomTip,
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
