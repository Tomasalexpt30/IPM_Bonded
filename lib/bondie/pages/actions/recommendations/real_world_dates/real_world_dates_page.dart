import 'package:bondedapp/bondie/pages/actions/recommendations/real_world_dates/options/lisbon_christmas_lights_page.dart';
import 'package:bondedapp/bondie/pages/actions/recommendations/real_world_dates/options/omakase_wa_page.dart';
import 'package:bondedapp/bondie/pages/actions/recommendations/real_world_dates/options/tile_museum_page.dart';
import 'package:flutter/material.dart';
import '../../../../widget/animated_bondie_widget.dart';
import '../../../stats/bondie_stats_controller.dart';
import '../../../../../main.dart';

// KEEPING YOUR ORIGINAL IMPORTS (even if unused)
import 'options/zero_latency_page.dart';
import 'options/escape_room_page.dart';
import 'options/gulbenkian_page.dart';

class RealWorldDatesPage extends StatelessWidget {
  final BondieStatsController controller;

  const RealWorldDatesPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      // ===========================================================
      // BOTTOM NAVIGATION BAR
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
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: "Calendar"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Favorites"),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: "Profile"),
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
                    // HEADER
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
                            "Real-World Date Ideas",
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
                    // DATE LIST (ENGLISH)
                    // ===========================================================

                    _buildDateCard(
                      icon: Icons.videogame_asset_rounded,
                      title: "Zero Latency",
                      description: "A fully immersive and cooperative VR adventure.",
                      color: const Color(0xFF7AB6F6),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ZeroLatencyPage(controller: controller),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildDateCard(
                      icon: Icons.park_rounded,
                      title: "Gulbenkian Garden",
                      description: "A peaceful, romantic stroll through a beautiful Lisbon garden.",
                      color: const Color(0xFFF6A56D),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GulbenkianGardenPage(controller: controller)
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildDateCard(
                      icon: Icons.lock_outline_rounded,
                      title: "Escape Room",
                      description: "Solve clues together and escape before time runs out.",
                      color: const Color(0xFFA17BF6),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EscapeRoomPage(controller: controller)
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildDateCard(
                      icon: Icons.museum_rounded,
                      title: "Tile Museum",
                      description: "Explore the history and beauty of Portuguese tile art.",
                      color: const Color(0xFF8EC6FF),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TileMuseumPage(controller: controller)
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildDateCard(
                      icon: Icons.restaurant_rounded,
                      title: "Omakase WA",
                      description: "An intimate Japanese tasting experience with elegant dishes.",
                      color: const Color(0xFF5EC8A7),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OmakaseWaPage(controller: controller)
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildDateCard(
                      icon: Icons.church_rounded,
                      title: "Lisbon Christmas Lights",
                      description: "Walk through the magical holiday lights and Christmas markets.",
                      color: const Color(0xFFF69AB4),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => LisbonChristmasLightsPage(controller: controller)
                          ),
                        );
                      },
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
  // BACKGROUND
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
  // DATE CARD
  // ===========================================================
  Widget _buildDateCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}

// ===========================================================
// HEART PAINTER
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
  bool shouldRepaint(_) => false;
}
