import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../calendar_grid_controller.dart';
import '../../add_activity/calendar_activity_controller.dart';
import '../../edit_activity/edit_activity_sheet.dart';

class WeekGridView extends StatelessWidget {
  final CalendarGridController controller;
  final DateTime date;
  final CalendarActivityController activities;

  const WeekGridView({
    super.key,
    required this.controller,
    required this.date,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    final monday =
    date.subtract(Duration(days: date.weekday - 1));

    final weekDays =
    List.generate(7, (i) => monday.add(Duration(days: i)));

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return GestureDetector(
          onScaleUpdate: (details) {
            controller.updateRowHeight(details.scale);
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFDBEAFE), Color(0xFF96D5FD)],
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
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _DaysHeader(weekDays: weekDays),
                const SizedBox(height: 10),

                SizedBox(
                  height: 400,
                  child: _WeekScrollableHours(
                    controller: controller,
                    weekDays: weekDays,
                    activities: activities,
                  ),
                ),

                const SizedBox(height: 12),
                const _WeekLegendRow(),
              ],
            ),
          ),
        );
      },
    );
  }
}

/* ---------- DAYS HEADER ---------- */

class _DaysHeader extends StatelessWidget {
  final List<DateTime> weekDays;

  const _DaysHeader({required this.weekDays});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weekDays.map((day) {
          final isToday =
          DateUtils.isSameDay(day, DateTime.now());
          return Column(
            children: [
              Text(
                DateFormat("E").format(day),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isToday
                      ? const Color(0xFF2563EB)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "${day.day}",
                  style: TextStyle(
                    color:
                    isToday ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

/* ---------- SCROLLABLE HOURS ---------- */

class _WeekScrollableHours extends StatelessWidget {
  final CalendarGridController controller;
  final List<DateTime> weekDays;
  final CalendarActivityController activities;

  const _WeekScrollableHours({
    required this.controller,
    required this.weekDays,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    final totalHeight = controller.rowHeight * 24;

    return SingleChildScrollView(
      controller: controller.scrollController,
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: totalHeight,
        child: Stack(
          children: [
            _GridBackground(controller: controller),

            Row(
              children: [
                SizedBox(
                  width: 48,
                  child: Column(
                    children: List.generate(24, (hour) {
                      return SizedBox(
                        height: controller.rowHeight,
                        child: Text(
                          "${hour.toString().padLeft(2, '0')}:00",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                Expanded(
                  child: Row(
                    children: weekDays.map((day) {
                      return Expanded(
                        child: _WeekDayColumn(
                          day: day,
                          activities: activities,
                          controller: controller,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            Positioned(
              top: controller.getCurrentHourOffset(),
              left: 40,
              right: 0,
              child: const _CurrentTimeIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------- DAY COLUMN ---------- */

class _WeekDayColumn extends StatelessWidget {
  final DateTime day;
  final CalendarActivityController activities;
  final CalendarGridController controller;

  const _WeekDayColumn({
    required this.day,
    required this.activities,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final dayActivities =
    activities.getActivitiesForDay(day);

    return Stack(
      children: dayActivities.map((activity) {
        final start = activity.start;
        final end = activity.end;

        final top =
            (start.hour + start.minute / 60) *
                controller.rowHeight;

        final height =
            end.difference(start).inMinutes /
                60 *
                controller.rowHeight;

        return Positioned(
          top: top,
          left: 4,
          right: 4,
          height: height,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => EditActivitySheet(
                  activity: activity,
                  controller: activities,
                ),
              );
            },
            child: _ActivityBlock(activity: activity),
          ),
        );
      }).toList(),
    );
  }
}

/* ---------- GRID BACKGROUND ---------- */

class _GridBackground extends StatelessWidget {
  final CalendarGridController controller;

  const _GridBackground({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(24, (_) {
        return SizedBox(
          height: controller.rowHeight,
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Row(
                  children: List.generate(7, (i) {
                    return Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: i < 6
                                ? BorderSide(
                              color: Colors.white
                                  .withOpacity(0.5),
                            )
                                : BorderSide.none,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

/* ---------- ACTIVITY BLOCK ---------- */

class _ActivityBlock extends StatelessWidget {
  final dynamic activity;

  const _ActivityBlock({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
        activity.isCouple ? const Color(0xFFFFF0D5) : const Color(0xFFBBF7D0),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Text(
          activity.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

/* ---------- CURRENT TIME ---------- */

class _CurrentTimeIndicator extends StatelessWidget {
  const _CurrentTimeIndicator();

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: Container(height: 2, color: Colors.red),
        ),
      ],
    );
  }
}

/* ---------- LEGEND ---------- */

class _WeekLegendRow extends StatelessWidget {
  const _WeekLegendRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _LegendDot(color: Color(0xFFBBF7D0)),
        SizedBox(width: 6),
        Text("Individual"),
        SizedBox(width: 24),
        _LegendDot(color: Color(0xFFFFF0D5)),
        SizedBox(width: 6),
        Text("Couple"),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;

  const _LegendDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
