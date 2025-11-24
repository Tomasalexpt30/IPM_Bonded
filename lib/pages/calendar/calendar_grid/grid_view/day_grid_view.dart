import 'package:flutter/material.dart';
import '../calendar_grid_controller.dart';
import '../../add_activity/calendar_activity_controller.dart';
import '../../edit_activity/edit_activity_sheet.dart';

class DayGridView extends StatelessWidget {
  final CalendarGridController controller;
  final DateTime date;
  final CalendarActivityController activities;

  const DayGridView({
    super.key,
    required this.controller,
    required this.date,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    final hours = List.generate(24, (i) => "${i.toString().padLeft(2, '0')}:00");

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFDBEAFE), Color(0xFF96D5FD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DayHeader(date: date),
          const SizedBox(height: 10),

          SizedBox(
            height: 360,
            child: _ScrollableDayHours(
              controller: controller,
              hours: hours,
              date: date,
              activities: activities,
            ),
          ),

          const SizedBox(height: 18),

          // 🔥 LEGENDA AQUI
          const _DayLegend(),
        ],
      ),
    );
  }
}

class _DayHeader extends StatelessWidget {
  final DateTime date;

  const _DayHeader({required this.date});

  @override
  Widget build(BuildContext context) {
    final weekdayNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    final weekday = weekdayNames[date.weekday - 1];

    return Padding(
      padding: const EdgeInsets.only(left: 48),
      child: Text(
        "$weekday ${date.day}",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}

class _ScrollableDayHours extends StatelessWidget {
  final CalendarGridController controller;
  final List<String> hours;
  final DateTime date;
  final CalendarActivityController activities;

  const _ScrollableDayHours({
    required this.controller,
    required this.hours,
    required this.date,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    final todayActivities = activities.getActivitiesForDay(date);

    return SingleChildScrollView(
      controller: controller.scrollController,
      physics: const BouncingScrollPhysics(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: hours.map((hourLabel) {
              return SizedBox(
                height: CalendarGridController.rowHeight,
                child: Row(
                  children: [
                    SizedBox(
                      width: 48,
                      child: Text(
                        hourLabel,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.75),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white.withOpacity(0.55),
                              width: 1.2,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),

          ...todayActivities.map((a) {
            final startOffset =
                a.start.hour * CalendarGridController.rowHeight +
                    (a.start.minute / 60) * CalendarGridController.rowHeight;

            final endOffset =
                a.end.hour * CalendarGridController.rowHeight +
                    (a.end.minute / 60) * CalendarGridController.rowHeight;

            final height = endOffset - startOffset;

            return Positioned(
              top: startOffset,
              left: 48,
              right: 0,
              height: height,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => EditActivitySheet(
                      activity: a,
                      controller: activities,
                    ),
                  );
                },
                child: _ActivityBlock(activity: a),
              ),
            );
          }).toList(),

          AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final offset = controller.getCurrentHourOffset();
              return Positioned(
                top: offset,
                left: 0,
                right: 0,
                child: const _CurrentTimeIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActivityBlock extends StatelessWidget {
  final CalendarActivity activity;

  const _ActivityBlock({required this.activity});

  Color _getColor() {
    if (activity.isCouple) {
      return const Color(0xFFFFF0D5);
    }
    return const Color(0xFFBBF7D0); // verde claro
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        activity.name,
        style: const TextStyle(
          fontFamily: "Poppins",
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}

class _CurrentTimeIndicator extends StatelessWidget {
  const _CurrentTimeIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Container(
              height: 2,
              color: Colors.red.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayLegend extends StatelessWidget {
  const _DayLegend();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(
          label: "Individual",
          color: const Color(0xFFBBF7D0),
        ),
        const SizedBox(width: 14),
        _legendItem(
          label: "Couple",
          color: const Color(0xFFFFF0D5),
        ),
      ],
    );
  }

  Widget _legendItem({required String label, required Color color}) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}

