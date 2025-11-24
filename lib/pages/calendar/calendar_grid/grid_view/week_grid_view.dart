import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../calendar_grid_controller.dart';

// atividades
import '../../add_activity/calendar_activity_controller.dart';

// sheet de edição
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
    final int weekday = date.weekday;
    final DateTime monday = date.subtract(Duration(days: weekday - 1));

    final List<DateTime> weekDays =
    List.generate(7, (i) => monday.add(Duration(days: i)));

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
          _DaysHeader(weekDays: weekDays),
          const SizedBox(height: 10),

          SizedBox(
            height: 360,
            child: _WeekScrollableHours(
              controller: controller,
              weekDays: weekDays,
              activities: activities,
            ),
          ),
        ],
      ),
    );
  }
}

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
          final bool isToday = DateUtils.isSameDay(day, DateTime.now());

          return Column(
            children: [
              Text(
                DateFormat("E").format(day),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 3),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isToday ? const Color(0xFF2563EB) : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "${day.day}",
                  style: TextStyle(
                    color: isToday ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}

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
    final double totalHeight = CalendarGridController.rowHeight * 24;

    return SingleChildScrollView(
      controller: controller.scrollController,
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: totalHeight,
        child: Stack(
          children: [
            /// BACKGROUND GRID
            const Positioned.fill(child: _WeekGridBackground()),

            /// HOURS + DAY COLUMNS
            Positioned.fill(
              child: Row(
                children: [
                  // LEFT HOURS
                  SizedBox(
                    width: 48,
                    child: Column(
                      children: List.generate(24, (hour) {
                        return SizedBox(
                          height: CalendarGridController.rowHeight,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${hour.toString().padLeft(2, '0')}:00",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.75),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  // WEEK COLUMNS
                  Expanded(
                    child: Row(
                      children: weekDays.map((day) {
                        return Expanded(
                          child: _WeekDayColumn(
                            day: day,
                            activities: activities,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            /// CURRENT TIME LINE
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
      ),
    );
  }
}

class _WeekDayColumn extends StatelessWidget {
  final DateTime day;
  final CalendarActivityController activities;

  const _WeekDayColumn({
    required this.day,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    final dayActivities = activities.getActivitiesForDay(day);

    return Stack(
      children: dayActivities.map((activity) {
        final start = activity.start;
        final end = activity.end;

        final double startOffset =
            (start.hour + start.minute / 60) * CalendarGridController.rowHeight;

        final double durationHours =
            end.difference(start).inMinutes / 60.0;

        final double blockHeight =
            durationHours * CalendarGridController.rowHeight;

        return Positioned(
          top: startOffset,
          left: 4,
          right: 4,
          height: blockHeight,
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

class _WeekGridBackground extends StatelessWidget {
  const _WeekGridBackground();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(24, (hour) {
        return Expanded(
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
                              color: Colors.white.withOpacity(0.55),
                              width: 1.2,
                            )
                                : BorderSide.none,
                            bottom: hour < 23
                                ? BorderSide(
                              color: Colors.white.withOpacity(0.55),
                              width: 1.2,
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

class _ActivityBlock extends StatelessWidget {
  final CalendarActivity activity;

  const _ActivityBlock({required this.activity});

  /// SAME LOGIC AS DAY VIEW
  Color _getColor() {
    if (activity.isCouple) {
      return const Color(0xFFFFF0D5);
    }
    return const Color(0xFFBBF7D0); // Verde claro
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Text(
          activity.name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
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
