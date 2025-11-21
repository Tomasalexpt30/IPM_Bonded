import 'package:flutter/material.dart';
import 'package:bondedapp/layout/app_background.dart';
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

  @override
  Widget build(BuildContext context) {
    final isEmpty = _controller.text.trim().isEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),

      body: AppBackground(
        child: SafeArea(
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
                      backgroundColor: const Color(0xFF3B82F6),
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
