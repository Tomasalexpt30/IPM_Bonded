import 'dart:math';
import 'package:flutter/material.dart';

class CoupleProfileInfo extends StatefulWidget {
  final DateTime relationshipStartDate;
  final int tripsTogether;
  final String songTitle;
  final String songArtist;
  final String albumCover;

  const CoupleProfileInfo({
    super.key,
    required this.relationshipStartDate,
    required this.tripsTogether,
    required this.songTitle,
    required this.songArtist,
    required this.albumCover,
  });

  @override
  State<CoupleProfileInfo> createState() => _CoupleProfileInfoState();
}

class _CoupleProfileInfoState extends State<CoupleProfileInfo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysTogether = now.difference(widget.relationshipStartDate).inDays;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.18),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [
          const Text(
            "Bruno & Ana",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CircleAvatar(radius: 38, backgroundImage: AssetImage("assets/images/user1.png")),
              Icon(
                Icons.favorite_rounded,
                size: 55,
                color: Color(0xFF3B82F6), // Azul Bonded
              ),

              CircleAvatar(radius: 38, backgroundImage: AssetImage("assets/images/user2.png")),
            ],
          ),

          const SizedBox(height: 30),

          // ======================================================
          // COUPLE INFO BOX
          // ======================================================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF5FF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                const Text(
                  "Couple Info",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF3B82F6),
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 22),

                // ======================================================
                // RESPONSIVE ROW (INFO + VINIL)
                // ======================================================
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ===========================
                        // INFO COLUMN
                        // ===========================
                        SizedBox(
                          width: constraints.maxWidth * 0.48,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _infoTile(
                                icon: Icons.watch_later,
                                label: "Days Together",
                                value: "$daysTogether days",
                              ),
                              const SizedBox(height: 22),

                              _infoTile(
                                icon: Icons.calendar_month_rounded,
                                label: "Anniversary",
                                value:
                                "${widget.relationshipStartDate.day.toString().padLeft(2, '0')} "
                                    "${_month(widget.relationshipStartDate.month)} "
                                    "${widget.relationshipStartDate.year}",
                              ),
                              const SizedBox(height: 22),

                              _infoTile(
                                icon: Icons.flight_takeoff_rounded,
                                label: "Trips Together",
                                value: "${widget.tripsTogether} trips",
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 32),



                        // ===========================
                        // VINYL + MUSIC SIDE
                        // ===========================
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10), // 🔥 aumenta aqui
                            child: Column(
                              children: [
                                AnimatedBuilder(
                                  animation: _controller,
                                  builder: (_, child) {
                                    return Transform.rotate(
                                      angle: _controller.value * 2 * pi,
                                      child: child,
                                    );
                                  },
                                  child: _buildVinyl(widget.albumCover, size: 110),
                                ),

                                const SizedBox(height: 10),

                                Text(
                                  widget.songTitle,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 2),

                                Text(
                                  widget.songArtist,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54.withOpacity(0.8),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // ======================================================
  // VINYL WITH DYNAMIC SIZE
  // ======================================================
  Widget _buildVinyl(String cover, {double size = 130}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.black,
                  Colors.grey.shade900,
                  Colors.black,
                ],
                stops: const [0.2, 0.6, 1.0],
              ),
            ),
          ),

          CustomPaint(
            size: Size(size, size),
            painter: _VinylRidgesPainter(),
          ),

          Container(
            width: size * 0.38,
            height: size * 0.38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(cover),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 1.8,
              ),
            ),
          ),

          Container(
            width: size * 0.07,
            height: size * 0.07,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
              border: Border.all(
                color: Colors.white.withOpacity(0.6),
                width: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  // INFO TILE
  // ======================================================
  Widget _infoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color(0xFFDCEAFF),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: Color(0xFF3B82F6),
          ),
        ),
        const SizedBox(width: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ======================================================
  // MONTH NAME
  // ======================================================
  String _month(int m) {
    const months = [
      "Jan","Feb","Mar","Apr","May","Jun",
      "Jul","Aug","Sep","Oct","Nov","Dec"
    ];
    return months[m - 1];
  }
}

// =========================================================
// VINYL RIDGES PAINTER
// =========================================================
class _VinylRidgesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    for (double r = maxRadius; r > 40; r -= 4) {
      canvas.drawCircle(center, r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
