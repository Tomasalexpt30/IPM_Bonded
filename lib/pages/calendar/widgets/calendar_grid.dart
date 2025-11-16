import 'package:flutter/material.dart';
import '../controller/calendar_grid_controller.dart';

class CalendarGrid extends StatelessWidget {
  final CalendarGridController controller;

  const CalendarGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
            color: Colors.blueGrey.withOpacity(0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _DaysRow(),
          const SizedBox(height: 10),
          _ScrollableHours(controller: controller),
        ],
      ),
    );
  }
}

// ---------------------- Days Row ---------------------------
class _DaysRow extends StatelessWidget {
  const _DaysRow();

  @override
  Widget build(BuildContext context) {
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Padding(
      padding: const EdgeInsets.only(left: 52),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(days.length, (i) {
          final isWeekend = i >= 5;

          return Text(
            days[i],
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        }),
      ),
    );
  }
}

// ---------------------- Hours Scroll ---------------------------
class _ScrollableHours extends StatelessWidget {
  final CalendarGridController controller;

  const _ScrollableHours({required this.controller});

  @override
  Widget build(BuildContext context) {
    final entries = List.generate(24, (hour) {
      final label = hour.toString().padLeft(2, '0') + ":00";
      return (label, List.filled(7, ""));
    });

    return SizedBox(
      height: 360,
      child: SingleChildScrollView(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: entries.map((e) {
            return _HourRow(
              hourLabel: e.$1,
              events: e.$2,
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ---------------------- Hour Row ---------------------------
class _HourRow extends StatelessWidget {
  final String hourLabel;
  final List<String?> events;

  const _HourRow({
    super.key,
    required this.hourLabel,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hour label
          SizedBox(
            width: 48,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                hourLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          Expanded(
            child: Row(
              children: List.generate(7, (index) {
                final activity = events[index];
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.25),
                        width: 1,
                      ),
                      color: activity == null || activity.isEmpty
                          ? Colors.white.withOpacity(0.10)
                          : null,
                    ),
                    child: activity == null || activity.isEmpty
                        ? null
                        : _ActivityBlock(title: activity),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------- Activity Block ---------------------------
class _ActivityBlock extends StatelessWidget {
  final String title;

  const _ActivityBlock({super.key, required this.title});

  Color _getColor() {
    if (title.contains("Spa")) return const Color(0xFFBBF7D0);
    if (title.contains("Gym")) return const Color(0xFFBFDBFE);
    if (title.contains("Date")) return const Color(0xFFFBCFE8);
    return Colors.white;
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
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
