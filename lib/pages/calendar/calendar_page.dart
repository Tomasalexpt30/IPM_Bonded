import 'package:flutter/material.dart';

import 'calendar_header/calendar_header.dart';
import 'calendar_header/calendar_header_controller.dart';

import 'calendar_grid/calendar_grid.dart';
import 'calendar_grid/calendar_grid_controller.dart';

import 'calendar_footer/calendar_footer.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final CalendarHeaderController headerController;
  late final CalendarGridController gridController;

  @override
  void initState() {
    super.initState();

    headerController = CalendarHeaderController();
    gridController = CalendarGridController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      gridController.scrollToCurrentHour();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: Stack(
        children: [
          _buildBackground(),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text(
                        "Couple Calendar",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    // HEADER CONTROLS
                    CalendarHeader(controller: headerController),
                    const SizedBox(height: 22),

                    // GRID VIEW (DAY/WEEK/MONTH/YEAR)
                    CalendarGrid(
                      controller: gridController,
                      headerController: headerController,
                    ),

                    const SizedBox(height: 22),

                    // FOOTER
                    const CalendarFooter(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BACKGROUND DECORATION
  // ============================================================
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

        Positioned(top: -45, left: -40,
            child: _heart(180, Colors.blueAccent.withOpacity(0.15))),
        Positioned(top: 140, left: -60,
            child: _heart(250, Colors.blueAccent.withOpacity(0.15))),
        Positioned(top: 60, right: 0,
            child: _heart(170, Colors.lightBlue.withOpacity(0.12))),
        Positioned(top: 200, left: 220,
            child: _heart(50, Colors.blue.withOpacity(0.08))),
        Positioned(top: 300, left: 180,
            child: _heart(90, Colors.blue.withOpacity(0.08))),
        Positioned(top: 420, left: 30,
            child: _heart(120, Colors.blueAccent.withOpacity(0.12))),
        Positioned(bottom: 145, right: -50,
            child: _heart(220, Colors.lightBlue.withOpacity(0.12))),
        Positioned(top: 220, right: -80,
            child: _heart(160, Colors.indigoAccent.withOpacity(0.15))),
        Positioned(bottom: -50, left: -50,
            child: _heart(200, Colors.lightBlue.withOpacity(0.12))),
        Positioned(bottom: 150, left: 140,
            child: _heart(70, Colors.indigoAccent.withOpacity(0.10))),
        Positioned(bottom: -150, right: -50,
            child: _heart(270, Colors.blueAccent.withOpacity(0.15))),
      ],
    );
  }

  static Widget _heart(double size, Color color) => CustomPaint(
    size: Size(size, size),
    painter: _HeartPainterCalendar(color),
  );
}

// ============================================================
// Heart painter
// ============================================================
class _HeartPainterCalendar extends CustomPainter {
  final Color color;
  _HeartPainterCalendar(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w / 2, h * 0.75);
    path.cubicTo(-w * 0.2, h * 0.35, w * 0.25, -h * 0.2, w / 2, h * 0.25);
    path.cubicTo(w * 0.75, -h * 0.2, w * 1.2, h * 0.35, w / 2, h * 0.75);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
