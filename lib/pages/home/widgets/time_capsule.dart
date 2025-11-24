import 'package:flutter/material.dart';

class TimeCapsuleCard extends StatefulWidget {
  const TimeCapsuleCard({super.key});

  @override
  State<TimeCapsuleCard> createState() => _TimeCapsuleCardState();
}

class _TimeCapsuleCardState extends State<TimeCapsuleCard> {
  bool isOpen = false;

  DateTime now = DateTime.now();

  // ⬅️ ABRE EM 2 DIAS
  DateTime openDate = DateTime.now().add(const Duration(days: 2));

  // ⬅️ FECHA 2 DIAS DEPOIS DE ABRIR (ajusta como quiseres)
  DateTime closeDate = DateTime.now().add(const Duration(days: 4));

  String themeValue = "The days you made me smile";

  @override
  void initState() {
    super.initState();

    // Atualiza o contador a cada segundo
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() => now = DateTime.now());
      return true;
    });
  }

  // =====================================================
  // 🔥 NOVA FUNÇÃO — cria frase elegante do tempo restante
  // =====================================================
  String _buildPrettyTime() {
    final diff = (isOpen ? closeDate : openDate).difference(now);

    if (diff.isNegative) return "0s";

    final days = diff.inDays;
    final hours = diff.inHours.remainder(24);
    final minutes = diff.inMinutes.remainder(60);
    final seconds = diff.inSeconds.remainder(60);

    if (days > 0) {
      return "$days day${days > 1 ? 's' : ''}, ${hours}h ${minutes}m";
    }

    if (hours > 0) {
      return "${hours}h ${minutes}m ${seconds}s";
    }

    if (minutes > 0) {
      return "${minutes}m ${seconds}s";
    }

    return "${seconds}s";
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
          // Ícone
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5DD),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.hourglass_bottom,
              size: 30,
              color: Color(0xFFDFA72A),
            ),
          ),

          const SizedBox(width: 18),

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

                // =====================================================
                // 🔥 "Closes in X days, Xh Xm Xs" (estilo muito melhorado)
                // =====================================================
                Row(
                  children: [
                    const Text(
                      "Closes in ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      _buildPrettyTime(),
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2563EB),
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
