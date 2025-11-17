import 'package:flutter/material.dart';
import '../calendar_header/calendar_header_controller.dart';
import 'calendar_grid_controller.dart';

// --- Grid views individuais ---
import 'grid_view/day_grid_view.dart';
import 'grid_view/week_grid_view.dart';
import 'grid_view/month_grid_view.dart';
import 'grid_view/year_grid_view.dart';

class CalendarGrid extends StatelessWidget {
  final CalendarGridController controller;
  final CalendarHeaderController headerController;

  const CalendarGrid({
    super.key,
    required this.controller,
    required this.headerController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: headerController,
      builder: (context, _) {
        switch (headerController.selectedSort) {
          case "Day":
            return DayGridView(
              controller: controller,
              date: headerController.currentDate,
            );

          case "Week":
            return WeekGridView(
              controller: controller,
              date: headerController.currentDate,
            );

          case "Month":
            return MonthGridView(
              date: headerController.currentDate,
            );

          case "Year":
            return YearGridView(
              date: headerController.currentDate,
            );

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
