import 'package:flutter/material.dart';
import '../calendar_grid_controller.dart';
import 'package:intl/intl.dart';

class WeekGridView extends StatelessWidget {
  final CalendarGridController controller;
  final DateTime date;

  const WeekGridView({
    super.key,
    required this.controller,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    // 🔹 Encontrar a segunda-feira da semana onde está a "date"
    final int weekday = date.weekday; // Monday=1 ... Sunday=7
    final DateTime monday = date.subtract(Duration(days: weekday - 1));

    // 🔹 Lista de 7 dias reais
    final List<DateTime> weekDays = List.generate(
      7,
          (i) => monday.add(Duration(days: i)),
    );

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
          _DaysRow(weekDays: weekDays),
          const SizedBox(height: 10),
          SizedBox(
            height: 360,
            child: _ScrollableHours(controller: controller),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------------
// HEADER DINÂMICO DOS DIAS DA SEMANA
// -------------------------------------------------------------------------
class _DaysRow extends StatelessWidget {
  final List<DateTime> weekDays;
  const _DaysRow({required this.weekDays});

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
                DateFormat("E").format(day), // Mon, Tue, Wed...
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
                  color: isToday ? Colors.blueAccent : Colors.transparent,
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

// -------------------------------------------------------------------------
// SCROLLABLE HOURS + LINHA VERMELHA
// -------------------------------------------------------------------------
class _ScrollableHours extends StatelessWidget {
  final CalendarGridController controller;

  const _ScrollableHours({required this.controller});

  @override
  Widget build(BuildContext context) {
    final entries = List.generate(24, (hour) {
      final label = hour.toString().padLeft(2, '0') + ":00";
      return (label, List.filled(7, ""));
    });

    return SingleChildScrollView(
      controller: controller.scrollController,
      physics: const BouncingScrollPhysics(),
      child: Stack(
        children: [
          Column(
            children: List.generate(entries.length, (i) {
              final e = entries[i];
              return _HourRow(
                hourLabel: e.$1,
                events: e.$2,
                isLastRow: i == entries.length - 1,
              );
            }),
          ),

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

// -------------------------------------------------------------------------
// UMA LINHA DE HORA
// -------------------------------------------------------------------------
class _HourRow extends StatelessWidget {
  final String hourLabel;
  final List<String?> events;
  final bool isLastRow;

  const _HourRow({
    super.key,
    required this.hourLabel,
    required this.events,
    required this.isLastRow,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CalendarGridController.rowHeight,
      child: Stack(
        children: [
          Row(
            children: [
              const SizedBox(width: 48),

              Expanded(
                child: Row(
                  children: List.generate(7, (index) {
                    final activity = events[index];

                    return Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: index < 6
                                ? BorderSide(
                              color: Colors.white.withOpacity(0.55),
                              width: 1.2,
                            )
                                : BorderSide.none,
                            bottom: !isLastRow
                                ? BorderSide(
                              color: Colors.white.withOpacity(0.55),
                              width: 1.2,
                            )
                                : BorderSide.none,
                          ),
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

          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              width: 48,
              child: Text(
                hourLabel,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.75),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------------
// ACTIVITY BLOCK
// -------------------------------------------------------------------------
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

// -------------------------------------------------------------------------
// LINHA VERMELHA
// -------------------------------------------------------------------------
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
