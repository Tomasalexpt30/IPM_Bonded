import 'package:flutter/material.dart';

class TimeCapsuleCard extends StatefulWidget {
  const TimeCapsuleCard({super.key});

  @override
  State<TimeCapsuleCard> createState() => _TimeCapsuleCardState();
}

class _TimeCapsuleCardState extends State<TimeCapsuleCard> {
  bool isOpen = false;
  DateTime now = DateTime.now();
  DateTime openDate = DateTime.now().add(const Duration(hours: 10));
  DateTime closeDate = DateTime.now().add(const Duration(hours: 20));

  String themeTitle = "Secret Theme:";
  String themeValue = "Anniversary Memories";

  String getTimeRemaining() {
    final target = isOpen ? closeDate : openDate;
    final diff = target.difference(now);
    if (diff.isNegative) return "00:00:00";

    final hours = diff.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = diff.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = diff.inSeconds.remainder(60).toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();
    // Atualiza contador da cápsula do tempo
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() => now = DateTime.now());
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Icon(
              isOpen ? Icons.lock_open_rounded : Icons.lock_rounded,
              color: const Color(0xDD000000),
              size: 28,
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  SizedBox(width: 8),
                  Text(
                    "Time Capsule",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // 🔹 Theme box with bold "Secret Theme:"
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF78BCE9), width: 2),
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white.withOpacity(0.8),
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Secret Theme: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800, // MAIS PESADO
                            color: Color(0xFF1D7CB6),
                          ),
                        ),
                        const TextSpan(
                          text: "Anniversary Memories",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2595DA),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Opens in: ",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    getTimeRemaining(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Color(0xFF165D88),
                      fontFamily: 'RobotoMono',
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
