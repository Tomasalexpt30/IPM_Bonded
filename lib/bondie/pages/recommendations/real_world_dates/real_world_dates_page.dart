import 'package:flutter/material.dart';
import '../../../widget/animated_bondie_widget.dart';
import '../../stats/bondie_stats_controller.dart';
import '../../../../main.dart';

class RealWorldDatesPage extends StatelessWidget {
  final BondieStatsController controller;

  const RealWorldDatesPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      // ===========================================================
      // BOTTOM NAVIGATION BAR — igual ao Recommendations
      // ===========================================================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.grey[600],
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
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: "Calendar",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded),
              label: "Messages",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "Profile",
            ),
          ],
        ),
      ),

      // ===========================================================
      // PAGE BODY
      // ===========================================================
      body: Stack(
        children: [
          _buildBackground(),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 6),

                    // ===========================================================
                    // HEADER — alinhado com Recommendations
                    // ===========================================================
                    SizedBox(
                      height: 40,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  size: 26,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),

                          const Text(
                            "Real-World Dates",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ===========================================================
                    // BONDIE HEADER — igual estrutura
                    // ===========================================================
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 38,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.12),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          AnimatedBondieWidget(controller: controller),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Plan Something Special",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Bondie selected real-life activities to make your moments together unforgettable.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 27),

                    // ===========================================================
                    // LISTA DE IDEIAS — espaçamentos iguais aos do Recommendations
                    // ===========================================================
                    _buildDateCard(
                      icon: Icons.local_cafe_rounded,
                      title: "Coffee Date",
                      description: "Enjoy each other’s company with warm drinks and slow conversation.",
                      color: const Color(0xFF7AB6F6),
                    ),
                    const SizedBox(height: 20),

                    _buildDateCard(
                      icon: Icons.park_rounded,
                      title: "Picnic in the Park",
                      description: "Snacks, fresh air and your favourite person — simple and perfect.",
                      color: const Color(0xFFA17BF6),
                    ),
                    const SizedBox(height: 20),

                    _buildDateCard(
                      icon: Icons.wb_sunny_rounded,
                      title: "Sunset Walk",
                      description: "Walk hand-in-hand while watching the colors fade into the night.",
                      color: const Color(0xFFF6A56D),
                    ),
                    const SizedBox(height: 20),

                    _buildDateCard(
                      icon: Icons.movie_rounded,
                      title: "Movie Night Out",
                      description: "Choose a film you both enjoy and share the big-screen experience.",
                      color: const Color(0xFFF69AB4),
                    ),
                    const SizedBox(height: 20),

                    _buildDateCard(
                      icon: Icons.restaurant_rounded,
                      title: "Dinner Date",
                      description: "Try a new restaurant or surprise your partner with their favorite place.",
                      color: const Color(0xFF5EC8A7),
                    ),
                    const SizedBox(height: 20),

                    _buildDateCard(
                      icon: Icons.menu_book_rounded,
                      title: "Bookstore Date",
                      description: "Pick a book for each other and explore cozy shelves together.",
                      color: const Color(0xFF8EC6FF),
                    ),
                    const SizedBox(height: 20),

                    _buildDateCard(
                      icon: Icons.sports_esports_rounded,
                      title: "Playful Activity",
                      description: "Bowling, mini-golf, arcade games — anything that brings laughter.",
                      color: const Color(0xFFC58AF9),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // BACKGROUND — igual ao Recommendations
  // ===========================================================
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

  static Widget _heart(double size, Color color) => CustomPaint(
    size: Size(size, size),
    painter: _HeartPainter(color),
  );

  // ===========================================================
  // DATE CARD — mesma estrutura dos category cards
  // ===========================================================
  Widget _buildDateCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
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
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Colors.black54,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================
// HEART PAINTER — igual
// ===========================================================
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
