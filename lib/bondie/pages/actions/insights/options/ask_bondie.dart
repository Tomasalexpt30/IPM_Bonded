import 'package:flutter/material.dart';

class AskBondieOption {
  static const Map<String, List<String>> categoryResponses = {
    "Give us a gentle reminder": [
      "A calm reminder: the tone you choose can change everything.",
      "Gentleness is powerful. Try choosing softer words today.",
      "Pause once today before reacting, it creates room for love.",
    ],
    "Share a bonding insight": [
      "Connection grows in tiny moments, not big events.",
      "Shared curiosity keeps relationships alive.",
      "Even a 10-second check-in can bring you closer.",
    ],
    "How can we communicate better?": [
      "Start with: “I want to understand you better.” It changes the whole tone.",
      "Speak to be understood, listen to understand.",
      "Tell each other one thing you need today, clarity is connection.",
    ],
    "What can we do as a team today?": [
      "Solve one tiny thing together. Small teamwork builds big unity.",
      "Share one goal for today, even a simple one.",
      "Choose one task to do side by side. It strengthens the ‘we’.",
    ],
    "Share something deep": [
      "Your relationship is a story, add a meaningful sentence today.",
      "Intimacy starts when you share what’s beneath the surface.",
      "Say something you feel but rarely express.",
    ],
    "Surprise us with wisdom": [
      "Gratitude spoken out loud multiplies closeness.",
      "Kindness is never wasted, especially in relationships.",
      "Softness during a hard moment is a superpower.",
    ],
  };

  static const List<String> options = [
    "Give us a gentle reminder",
    "Share a bonding insight",
    "How can we communicate better?",
    "What can we do as a team today?",
    "Share something deep",
    "Surprise us with wisdom",
  ];

  static void show(BuildContext context) {
    int? selectedIndex;
    String? response;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            void selectOption(int index) {
              setState(() {
                selectedIndex = index;

                final category = options[index];
                final list = List<String>.from(categoryResponses[category]!);
                list.shuffle();
                response = list.first;
              });
            }

            return DraggableScrollableSheet(
              initialChildSize: 0.60,
              minChildSize: 0.45,
              maxChildSize: 0.95,
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
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
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          "Ask Bondie Anything",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Choose a topic and Bondie will share something meaningful with you:",
                        style: TextStyle(
                          fontSize: 14.5,
                          color: Colors.black54,
                          height: 1.35,
                        ),
                      ),

                      const SizedBox(height: 14),

                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: options.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3.0,
                        ),
                        itemBuilder: (context, i) {
                          return _askGridButton(
                            text: options[i],
                            isSelected: selectedIndex == i,
                            onTap: () => selectOption(i),
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      Flexible(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4, right: 10),
                                child: Image.asset(
                                  "assets/images/bondie_icons/bondie_talking.png",
                                  height: 65,
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
                                    selectedIndex == null
                                        ? "Ask me anything… I'm listening 💙"
                                        : response!,
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
      },
    );
  }

  static Widget _askGridButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final Color selectedBg = const Color(0xFFD8EAFE);
    final Color selectedBorder = const Color(0xFF3B82F6);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : const Color(0xFFF3F6FF),
          borderRadius: BorderRadius.circular(18),
          border: isSelected
              ? Border.all(color: selectedBorder, width: 1.4)
              : Border.all(color: Colors.transparent),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.16),
              blurRadius: 9,
              offset: const Offset(0, 3),
            )
          ]
              : [],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: Colors.black87,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
