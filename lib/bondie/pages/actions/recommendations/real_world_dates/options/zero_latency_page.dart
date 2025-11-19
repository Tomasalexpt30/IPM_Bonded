import 'package:flutter/material.dart';
import '../../../../../widget/animated_bondie_widget.dart';
import '../../../../stats/bondie_stats_controller.dart';
import '../../../../../../main.dart';
import 'package:url_launcher/url_launcher.dart';

class ZeroLatencyPage extends StatelessWidget {
  final BondieStatsController controller;

  const ZeroLatencyPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      bottomNavigationBar: _buildBottomBar(context),

      body: Stack(
        children: [
          _buildBackground(),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            "Zero Latency VR",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 26),

                    _mainInfoBlock(context),
                    const SizedBox(height: 26),

                    _bondieWhySection(),
                    const SizedBox(height: 26),

                    _tipsSection(),
                    const SizedBox(height: 26),

                    _smallInfoRow(),
                    const SizedBox(height: 60),
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
  // MAIN INFO BLOCK
  // ===========================================================
  Widget _mainInfoBlock(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              height: 120,
              width: double.infinity,
              color: Colors.white,
              child: Image.asset(
                "assets/images/recommendations/zero_latency_logo.webp",
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 0),

          const Text(
            "Zero Latency is a next-generation virtual reality experience — "
                "completely wireless and full-scale. You walk freely in a large physical space "
                "while exploring highly immersive virtual worlds. "
                "It’s one of the most intense, cooperative, and memorable date activities you can do!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(
                child: _iconButton(
                  icon: Icons.link_rounded,
                  label: "Website",
                  color: const Color(0xFF2FB0EC),
                  onTap: () => launchUrl(
                    Uri.parse("https://zerolatencyvr.com/"),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _iconButton(
                  icon: Icons.location_on_rounded,
                  label: "Location",
                  color: const Color(0xFF2FB0EC),
                  onTap: () => launchUrl(
                    Uri.parse("https://maps.google.com/?q=Zero+Latency+Lisboa"),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _addToCalendarButton(),
        ],
      ),
    );
  }

  // ===========================================================
  // REUSABLE BUTTON
  // ===========================================================
  Widget _iconButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.11),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // ADD TO CALENDAR BUTTON
  // ===========================================================
  Widget _addToCalendarButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6).withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.event_available_rounded, color: Color(0xFF3B82F6)),
            SizedBox(width: 8),
            Text(
              "Add to Calendar",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3B82F6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // TIPS SECTION
  // ===========================================================
  Widget _tipsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.lightbulb_rounded, color: Color(0xFF3B82F6)),
              SizedBox(width: 8),
              Text(
                "Tips to Make It Even Better",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _tipCard(
            number: "1",
            title: "Wear comfortable clothes",
            subtitle: "You'll move a lot — comfort makes a big difference.",
          ),
          const SizedBox(height: 10),

          _tipCard(
            number: "2",
            title: "Pick cooperative games",
            subtitle: "Playing together is far more fun and engaging.",
          ),
          const SizedBox(height: 10),

          _tipCard(
            number: "3",
            title: "Book in advance",
            subtitle: "Slots fill up quickly, especially on weekends.",
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // TIP CARD (GIANT NUMBER)
  // ===========================================================
  Widget _tipCard({
    required String number,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
              height: 1.0,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // BONDIE EXPLAINS
  // ===========================================================
  Widget _bondieWhySection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Image.asset(
            "assets/images/bondie_icons/bondie_talking.png",
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Text(
              "This experience is amazing for strengthening your connection! "
                  "You’ll need to communicate, cooperate, make quick decisions together, "
                  "and trust each other. It’s fun, intense, and creates unforgettable memories!",
              style: TextStyle(
                fontSize: 14,
                height: 1.45,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================
  // SMALL INFO SQUARES
  // ===========================================================
  Widget _smallInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _smallSquare(Icons.schedule_rounded, "Duration", "30–45m")),
        const SizedBox(width: 12),
        Expanded(child: _smallSquare(Icons.euro_rounded, "Price", "25–35€")),
        const SizedBox(width: 12),
        Expanded(child: _smallSquare(Icons.lock_person_rounded, "Age", "+13")),
      ],
    );
  }

  Widget _smallSquare(IconData icon, String title, String value) {
    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: const Color(0xFF3B82F6)),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // NAV BAR
  // ===========================================================
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.grey[700],
        unselectedItemColor: Colors.grey[500],
        iconSize: 30,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        onTap: (index) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => MainScreenWithIndex(index: index)),
                (_) => false,
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: "Calendar"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: "Profile"),
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
              colors: [
                Color(0xFFF8FAFF),
                Color(0xFFE9F1FF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(top: -40, left: -40, child: _heart(160, Colors.blueAccent.withOpacity(0.05))),
        Positioned(top: 160, left: -60, child: _heart(220, Colors.lightBlue.withOpacity(0.05))),
        Positioned(top: 60, right: -30, child: _heart(150, Colors.indigo.withOpacity(0.05))),
        Positioned(bottom: 80, right: -40, child: _heart(180, Colors.blue.withOpacity(0.05))),
        Positioned(bottom: -40, left: -40, child: _heart(180, Colors.lightBlue.withOpacity(0.05))),
      ],
    );
  }

  static Widget _heart(double size, Color color) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HeartPainter(color),
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
  bool shouldRepaint(_) => false;
}
