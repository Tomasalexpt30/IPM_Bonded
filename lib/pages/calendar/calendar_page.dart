import 'package:flutter/material.dart';
import 'package:bondedapp/layout/app_background.dart';
import 'calendar_header/calendar_header.dart';
import 'calendar_header/calendar_header_controller.dart';
import 'calendar_grid/calendar_grid.dart';
import 'calendar_grid/calendar_grid_controller.dart';
import 'calendar_footer/calendar_footer.dart';
import 'add_activity/calendar_activity_controller.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final CalendarHeaderController headerController;
  late final CalendarGridController gridController;
  late final CalendarActivityController activityController;

  @override
  void initState() {
    super.initState();
    headerController = CalendarHeaderController();
    gridController = CalendarGridController();
    activityController = CalendarActivityController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gridController.scrollToCurrentHour();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      body: AppBackground(
        child: SafeArea(
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

                  // Title
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

                  CalendarHeader(controller: headerController),
                  const SizedBox(height: 20),

                  CalendarGrid(
                    controller: gridController,
                    headerController: headerController,
                    activityController: activityController,
                  ),
                  const SizedBox(height: 18),

                  CalendarFooter(controller: activityController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
