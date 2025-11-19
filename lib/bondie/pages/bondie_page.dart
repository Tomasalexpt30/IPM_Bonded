import 'package:flutter/material.dart';
import '../../main.dart';
import 'stats/bondie_stats.dart';
import 'stats/bondie_stats_controller.dart';
import 'actions/bondie_actions_page.dart';

class BondiePage extends StatefulWidget {
  final BondieStatsController statsController;

  const BondiePage({
    super.key,
    required this.statsController,
  });

  @override
  State<BondiePage> createState() => _BondiePageState();
}

class _BondiePageState extends State<BondiePage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      bottomNavigationBar: _buildBottomNavBar(),

      body: Stack(
        children: [
          _buildBackground(),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bondie",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 0),

                  // ⭐ Bondie Stats (imagem + mood + circular stats)
                  BondieStats(
                    floatAnimation: _floatAnimation,
                    controller: widget.statsController, // <-- AQUI!!!
                  ),

                  const SizedBox(height: 13),

                  // ⭐ Action Cards
                  BondieActions(controller: widget.statsController),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // Bottom navigation bar
  // ----------------------------------------------------------
  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.grey[500],
        unselectedItemColor: Colors.grey[500],
        iconSize: 30,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        onTap: (index) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => MainScreenWithIndex(index: index),
            ),
                (_) => false,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Favorites"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // Background
  // ----------------------------------------------------------
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

        // 💙 Corações decorativos
        Positioned(
          top: -45,
          left: -40,
          child: _heart(180, Colors.blueAccent.withOpacity(0.08)),
        ),
        Positioned(
          top: 140,
          left: -60,
          child: _heart(250, Colors.blueAccent.withOpacity(0.08)),
        ),
        Positioned(
          top: 60,
          right: 0,
          child: _heart(170, Colors.lightBlue.withOpacity(0.08)),
        ),
        Positioned(
          top: 200,
          left: 220,
          child: _heart(50, Colors.blue.withOpacity(0.08)),
        ),
        Positioned(
          top: 300,
          left: 180,
          child: _heart(90, Colors.blue.withOpacity(0.08)),
        ),
        Positioned(
          top: 420,
          left: 30,
          child: _heart(120, Colors.blueAccent.withOpacity(0.08)),
        ),
        Positioned(
          bottom: 145,
          right: -50,
          child: _heart(220, Colors.lightBlue.withOpacity(0.08)),
        ),
        Positioned(
          top: 220,
          right: -80,
          child: _heart(160, Colors.indigoAccent.withOpacity(0.08)),
        ),
        Positioned(
          bottom: -50,
          left: -50,
          child: _heart(200, Colors.lightBlue.withOpacity(0.08)),
        ),
        Positioned(
          bottom: 150,
          left: 140,
          child: _heart(70, Colors.indigoAccent.withOpacity(0.08)),
        ),
        Positioned(
          bottom: -150,
          right: -50,
          child: _heart(270, Colors.blueAccent.withOpacity(0.08)),
        ),
      ],
    );
  }

  Widget _heart(double size, Color color) => CustomPaint(
    size: Size(size, size),
    painter: _HeartPainter(color),
  );
}

// ----------------------------------------------------------
// Painter do coração
// ----------------------------------------------------------
class _HeartPainter extends CustomPainter {
  final Color color;
  _HeartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width, h = size.height;

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
