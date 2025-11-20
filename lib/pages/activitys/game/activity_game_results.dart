import 'package:flutter/material.dart';

class ActivityGameResultsPage extends StatelessWidget {
  final List<String> prompts;
  final List<String> answers;

  const ActivityGameResultsPage({
    super.key,
    required this.prompts,
    required this.answers,
  });

  // Respostas fixas da parceira (Sofia)
  final List<String> partnerAnswers = const [
    "Bruno",
    "Both",
    "Ana",
    "Bruno",
    "Both",
  ];

  // Matching calculation
  int _calculateMatch() {
    int match = 0;
    for (int i = 0; i < answers.length; i++) {
      if (answers[i] == partnerAnswers[i]) {
        match++;
      }
    }
    return ((match / answers.length) * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    final matchValue = _calculateMatch();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      body: Stack(
        children: [
          _buildBackground(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 22),

                  _buildBondieMatchIntro(matchValue),
                  const SizedBox(height: 22),

                  Expanded(child: _buildResultsList()),

                  const SizedBox(height: 20),
                  _finishButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // HEADER -------------------------------------------------------
  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            "Game Results",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
// BONDIE - MATCH BUBBLE (WITH AIRPODS-STYLE CIRCULAR GAUGE)
// ===============================================================
  Widget _buildBondieMatchIntro(int value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bondie
        Image.asset(
          "assets/images/bondie_icons/bondie_talking.png",
          height: 100,
          width: 100,
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // ======================================================
                // CÍRCULO COM O NÚMERO (CENTRADO)
                // ======================================================
                SizedBox(
                  height: 85,
                  width: 85,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: 1,
                          strokeWidth: 9,
                          backgroundColor: const Color(0xFFE4ECFF),
                          valueColor: const AlwaysStoppedAnimation(Color(0xFFE4ECFF)),
                        ),
                      ),
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: value / 100,
                          strokeWidth: 9,
                          strokeCap: StrokeCap.round,
                          backgroundColor: Colors.transparent,
                          valueColor: const AlwaysStoppedAnimation(Color(0xFF3B82F6)),
                        ),
                      ),
                      Text(
                        "$value%",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // ======================================================
                // TEXTO (CENTRADO ABAIXO DO CÍRCULO)
                // ======================================================
                const Text(
                  "Compatibility Score",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  // ===============================================================
// RESULTS LIST
// ===============================================================
  Widget _buildResultsList() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: prompts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 18),
      itemBuilder: (context, i) {
        final isMatch = answers[i] == partnerAnswers[i];
        return _resultCard(i, isMatch);
      },
    );
  }

  Widget _resultCard(int i, bool isMatch) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.15),
                blurRadius: 16,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pergunta
              Text(
                "${i + 1}. ${prompts[i]}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 14),

              // Partner answer
              _answerRow(
                avatar: "assets/images/user2.png",
                answer: partnerAnswers[i],
              ),
              const SizedBox(height: 10),

              // Your answer
              _answerRow(
                avatar: "assets/images/user1.png",
                answer: answers[i],
              ),

            ],
          ),
        ),

        // MATCH / MISMATCH ICON  ------------------------------------
        Positioned(
          right: 20,
          bottom: 20,
          child: Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: isMatch
                  ? const Color(0xFFDDEBFF)  // azul muito suave
                  : const Color(0xFFFFE5E9), // vermelho suave
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              isMatch ? Icons.favorite_rounded : Icons.close_rounded,
              size: 26,
              color: isMatch
                  ? const Color(0xFF3B82F6)  // azul forte
                  : const Color(0xFFE11D48), // vermelho forte
            ),
          ),
        ),
      ],
    );
  }


  // ===============================================================
// SINGLE ANSWER ROW — WITH TIGHT BLUE PILL
// ===============================================================
  Widget _answerRow({
    required String avatar,
    required String answer,
  }) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            avatar,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),

        // Bubble adjusts to text size
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F1FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            answer,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }


  // BUTTON --------------------------------------------------------
  Widget _finishButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: const Text(
          "Done",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // BACKGROUND ---------------------------------------------------
  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF8FAFF), Color(0xFFE9F1FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(top: -45, left: -40, child: _heart(180)),
        Positioned(top: 140, left: -60, child: _heart(250)),
        Positioned(top: 60, right: 0, child: _heart(170)),
        Positioned(top: 200, left: 220, child: _heart(50)),
        Positioned(top: 300, left: 180, child: _heart(90)),
        Positioned(top: 420, left: 30, child: _heart(120)),
        Positioned(bottom: 145, right: -50, child: _heart(220)),
        Positioned(top: 220, right: -80, child: _heart(160)),
        Positioned(bottom: -50, left: -50, child: _heart(200)),
        Positioned(bottom: 150, left: 140, child: _heart(70)),
        Positioned(bottom: -150, right: -50, child: _heart(270)),
      ],
    );
  }

  Widget _heart(double size) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HeartPainter(Colors.blueAccent.withOpacity(0.08)),
    );
  }
}

class _HeartPainter extends CustomPainter {
  final Color color;
  _HeartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(w / 2, h * 0.75)
      ..cubicTo(-w * 0.2, h * 0.35, w * 0.25, -h * 0.2, w / 2, h * 0.25)
      ..cubicTo(w * 0.75, -h * 0.2, w * 1.2, h * 0.35, w / 2, h * 0.75)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
