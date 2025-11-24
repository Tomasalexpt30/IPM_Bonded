import 'package:flutter/material.dart';
import 'activity_question_result.dart';

class ActivityQuestionPage extends StatefulWidget {
  const ActivityQuestionPage({super.key});

  @override
  State<ActivityQuestionPage> createState() => _ActivityQuestionPageState();
}

class _ActivityQuestionPageState extends State<ActivityQuestionPage> {
  final String question =
      "What is one small thing you could do today to make your partner feel appreciated?";

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ActivityQuestionResultPage(
          question: question,
          userAnswer: text,
        ),
      ),
    );
  }

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

        Positioned(top: -45, left: -40, child: _heart(180, Colors.blueAccent.withOpacity(0.08))),
        Positioned(top: 140, left: -60, child: _heart(250, Colors.blueAccent.withOpacity(0.08))),
        Positioned(top: 60, right: 0, child: _heart(170, Colors.lightBlue.withOpacity(0.08))),
        Positioned(top: 200, left: 220, child: _heart(50, Colors.blue.withOpacity(0.08))),
        Positioned(top: 300, left: 180, child: _heart(90, Colors.blue.withOpacity(0.08))),
        Positioned(top: 365, right: 35, child: _heart(60, Colors.lightBlue.withOpacity(0.08))),
        Positioned(top: 420, left: 30, child: _heart(120, Colors.blueAccent.withOpacity(0.08))),
        Positioned(bottom: 105, right: -80, child: _heart(220, Colors.lightBlue.withOpacity(0.08))),
        Positioned(top: 220, right: -80, child: _heart(160, Colors.indigoAccent.withOpacity(0.08))),
        Positioned(bottom: -50, left: -50, child: _heart(200, Colors.lightBlue.withOpacity(0.08))),
        Positioned(bottom: 150, left: 140, child: _heart(70, Colors.indigoAccent.withOpacity(0.08))),
        Positioned(bottom: -150, right: -50, child: _heart(270, Colors.blueAccent.withOpacity(0.08))),
        Positioned(bottom: 280, right: 20, child: _heart(200, Colors.blueAccent.withOpacity(0.08))),
      ],
    );
  }

  Widget _heart(double size, Color color) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HeartPainter(color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEmpty = _controller.text.trim().isEmpty;

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
                  const SizedBox(height: 20),

                  _buildBondieQuestion(),
                  const SizedBox(height: 30),

                  const Spacer(),

                  _buildAnswerInput(),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isEmpty ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFF93C5FD),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        "Submit Answer",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_rounded, size: 28),
            ),
          ),
          const Text(
            "Daily Question",
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

  Widget _buildBondieQuestion() {
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
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
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
              children: [
                const Text(
                  "Bondie asks...",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(height: 6),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    question,
                    key: const ValueKey("daily_question"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 1.35,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerInput() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.15),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your answer...",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),

          TextField(
            controller: _controller,
            maxLines: 8,
            minLines: 6,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              hintText: "Write freely here...",
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeartPainter extends CustomPainter {
  final Color color;
  _HeartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
