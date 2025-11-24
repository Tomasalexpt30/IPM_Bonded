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

  String themeValue = "The days you made me smile";

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

          // ÍCONE AMARELO TORRADO
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5DD), // fundo pastel amarelo suave
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.hourglass_bottom,
              size: 30,
              color: Color(0xFFDFA72A), // amarelo torrado
            ),
          ),

          const SizedBox(width: 18),

          // TEXTOS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Time Capsule",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 8),

                // SECRET THEME APRIMORADO
                Text(
                  "“$themeValue”",
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                    height: 1.35,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Text(
                      "Opens in: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      getTimeRemaining(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2563EB),
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  ],
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
    );
  }
}
