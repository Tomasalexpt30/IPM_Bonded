import 'package:flutter/material.dart';
import 'activity_game_results.dart';

class ActivityGamePage extends StatefulWidget {
  const ActivityGamePage({super.key});

  @override
  State<ActivityGamePage> createState() => _ActivityGamePageState();
}

class _ActivityGamePageState extends State<ActivityGamePage> {
  final List<String> prompts = [
    "Who is more capable of organizing a surprise date?",
    "Who is more likely to start a spontaneous trip?",
    "Who is better at keeping secrets?",
    "Who cooks the best meal?",
    "Who is more romantic on a random Tuesday?",
  ];

  int currentIndex = 0;

  final List<String> answers = [];

  void _selectAnswer(String answer) {
    answers.add(answer);

    final isLast = currentIndex == prompts.length - 1;

    if (isLast) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ActivityGameResultsPage(
            prompts: prompts,
            answers: answers,
          ),
        ),
      );
      return;
    }

    setState(() {
      currentIndex++;
    });
  }

  // ================================================================
  // ROOT
  // ================================================================
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
                  const SizedBox(height: 20),

                  _buildBondieSpeech(),
                  const SizedBox(height: 40),

                  const Spacer(),

                  // AVATARS
                  Row(
                    children: [
                      Expanded(
                        child: _TapAnimatedHighlight(
                          child: _avatarChoice(
                            name: "Bruno",
                            image: "assets/images/user1.png",
                          ),
                          onTap: () => _selectAnswer("Bruno"),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _TapAnimatedHighlight(
                          child: _avatarChoice(
                            name: "Ana",
                            image: "assets/images/user2.png",
                          ),
                          onTap: () => _selectAnswer("Ana"),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // BOTH & NEITHER
                  Column(
                    children: [
                      _TapAnimatedHighlight(
                        child: _pillButton(
                          label: "Both",
                          icon: Icons.people_rounded,
                          color: const Color(0xFF3B82F6),
                        ),
                        onTap: () => _selectAnswer("Both"),
                      ),
                      const SizedBox(height: 12),
                      _TapAnimatedHighlight(
                        child: _pillButton(
                          label: "Neither",
                          icon: Icons.block_rounded,
                          color: const Color(0xFFE11D48),
                        ),
                        onTap: () => _selectAnswer("Neither"),
                      ),
                    ],
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

  // ================================================================
  // HEADER
  // ================================================================
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
            "Daily Game",
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

  // ================================================================
  // SPEECH BUBBLE
  // ================================================================
  Widget _buildBondieSpeech() {
    final q = currentIndex + 1;
    final total = prompts.length;

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
                Text(
                  "$q / $total",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(height: 6),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    prompts[currentIndex],
                    key: ValueKey(currentIndex),
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

  // ================================================================
  // AVATAR CARD
  // ================================================================
  Widget _avatarChoice({
    required String name,
    required String image,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
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
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFF75ABF3), width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                image,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // PILL BUTTON (both / neither)
  // ================================================================
  Widget _pillButton({
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // BACKGROUND
  // ================================================================
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
        Positioned(top: 420, left: 30, child: _heart(120, Colors.blueAccent.withOpacity(0.08))),
        Positioned(bottom: 145, right: -50, child: _heart(220, Colors.lightBlue.withOpacity(0.08))),
        Positioned(top: 220, right: -80, child: _heart(160, Colors.indigoAccent.withOpacity(0.08))),
        Positioned(bottom: -50, left: -50, child: _heart(200, Colors.lightBlue.withOpacity(0.08))),
        Positioned(bottom: 150, left: 140, child: _heart(70, Colors.indigoAccent.withOpacity(0.08))),
        Positioned(bottom: -150, right: -50, child: _heart(270, Colors.blueAccent.withOpacity(0.08))),
      ],
    );
  }

  Widget _heart(double size, Color color) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HeartPainter(color),
    );
  }
}

// =============================================================
// HEART PAINTER
// =============================================================
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

// =============================================================
// UNIVERSAL TAP ANIMATION (scale + color + BLUE BORDER)
// =============================================================
class _TapAnimatedHighlight extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _TapAnimatedHighlight({
    required this.child,
    required this.onTap,
  });

  @override
  State<_TapAnimatedHighlight> createState() => _TapAnimatedHighlightState();
}

class _TapAnimatedHighlightState extends State<_TapAnimatedHighlight> {
  double _scale = 1.0;
  double _highlight = 0.0;
  double _borderAlpha = 0.0;

  Future<void> _animate() async {
    setState(() {
      _scale = 0.94;
      _highlight = 1.0;
      _borderAlpha = 1.0;
    });

    await Future.delayed(const Duration(milliseconds: 140));

    setState(() {
      _scale = 1.0;
      _highlight = 0.0;
      _borderAlpha = 0.0;
    });

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 90),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 90),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.10 * _highlight),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: Color(0xFF75ABF3).withOpacity(_borderAlpha),
            width: 2,
          ),
        ),
        child: GestureDetector(
          onTap: _animate,
          child: widget.child,
        ),
      ),
    );
  }
}
