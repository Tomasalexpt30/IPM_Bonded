import 'package:flutter/material.dart';
import '../calendar_header/calendar_header_controller.dart';
import 'calendar_grid_controller.dart';

// --- Grid views individuais ---
import 'grid_view/day_grid_view.dart';
import 'grid_view/week_grid_view.dart';
import 'grid_view/month_grid_view.dart';
import 'grid_view/year_grid_view.dart';

// 🔥 ADICIONADO — atividades
import '../add_activity/calendar_activity_controller.dart';

class CalendarGrid extends StatelessWidget {
  final CalendarGridController controller;
  final CalendarHeaderController headerController;

  // 🔥 ADICIONADO
  final CalendarActivityController activityController;

  const CalendarGrid({
    super.key,
    required this.controller,
    required this.headerController,
    required this.activityController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([headerController, activityController]),
      builder: (context, _) {
        switch (headerController.selectedSort) {
          case "Day":
            return DayGridView(
              controller: controller,
              date: headerController.currentDate,

              // 🔥 ADICIONADO
              activities: activityController,
            );

          case "Week":
            return WeekGridView(
              controller: controller,
              date: headerController.currentDate,

              // 🔥 ADICIONADO
              activities: activityController,
            );

          case "Month":
            return MonthGridView(
              date: headerController.currentDate,

              // 🔥 ADICIONADO
              activities: activityController,
            );

          case "Year":
            return YearGridView(
              date: headerController.currentDate,

              // 🔥 ADICIONADO
              activities: activityController,
            );

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
