import 'package:flutter/material.dart';

class ActivityQuestionResultPage extends StatelessWidget {
  final String question;
  final String userAnswer;

  const ActivityQuestionResultPage({
    super.key,
    required this.question,
    required this.userAnswer,
  });

  // Resposta automática do parceiro (gerada por mim)
  String get partnerAnswer {
    return switch (question) {
      _ when question.contains("appreciated") =>
      "I think a small moment of presence can make a big difference, maybe a warm hug or a message reminding them how much they matter.",
      _ when question.contains("love") =>
      "Showing love through small, thoughtful actions is powerful, sometimes listening deeply is all it takes.",
      _ =>
      "Sometimes it’s the little gestures that mean the most. A moment of kindness can warm the whole day.",
    };
  }

  @override
  Widget build(BuildContext context) {
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

                  _buildReflectionBubble(),
                  const SizedBox(height: 22),

                  Expanded(child: _buildAnswersCard()),

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

  // ===============================================================
  // HEADER
  // ===============================================================
  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            "Question Results",
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
  // REFLECTION BUBBLE
  // ===============================================================
  Widget _buildReflectionBubble() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "A moment to reflect...",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  "Let’s explore both perspectives and see how each of you connects with today’s question.",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
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
  // CARD COM RESPOSTAS
  // ===============================================================
  Widget _buildAnswersCard() {
    return Container(
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

      // Scroll interno
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.45,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Your answer
                  _answerRow(
                    label: "You wrote",
                    avatar: "assets/images/user1.png",
                    text: userAnswer,
                  ),
                  const SizedBox(height: 14),

                  // Partner answer
                  _answerRow(
                    label: "Ana wrote",
                    avatar: "assets/images/user2.png",
                    text: partnerAnswer,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ===============================================================
  // ROW TEMPLATE
  // ===============================================================
  Widget _answerRow({
    required String label,
    required String avatar,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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

        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  text,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===============================================================
  // BUTTON → FECHA TUDO E VOLTA PARA HOME
  // ===============================================================
  Widget _finishButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
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

  // ===============================================================
  // BACKGROUND
  // ===============================================================
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

// HEART PAINTER --------------------------------------------------
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
