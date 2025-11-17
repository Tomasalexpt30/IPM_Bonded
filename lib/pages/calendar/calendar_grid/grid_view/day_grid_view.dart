import 'package:flutter/material.dart';
import '../calendar_grid_controller.dart';

class DayGridView extends StatelessWidget {
  final CalendarGridController controller;
  final DateTime date;

  const DayGridView({
    super.key,
    required this.controller,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final hours =
    List.generate(24, (i) => "${i.toString().padLeft(2, '0')}:00");

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
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------------
// HEADER DO DIA (NOME DO DIA + DATA)
// -------------------------------------------------------------------------
class _DayHeader extends StatelessWidget {
  final DateTime date;

  const _DayHeader({required this.date});

  @override
  Widget build(BuildContext context) {
    final weekdayNames = [
      "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"
    ];

    final weekday = weekdayNames[date.weekday - 1];

    return Padding(
      padding: const EdgeInsets.only(left: 48),
      child: Text(
        "$weekday ${date.day}",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// SCROLL DOS HORÁRIOS + LINHA VERMELHA
// -------------------------------------------------------------------------
class _ScrollableDayHours extends StatelessWidget {
  final CalendarGridController controller;
  final List<String> hours;

  const _ScrollableDayHours({
    required this.controller,
    required this.hours,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller.scrollController,
      physics: const BouncingScrollPhysics(),
      child: Stack(
        children: [
          Column(
            children: hours.map((hour) {
              return _DayHourRow(
                hourLabel: hour,
                isLastRow: hour == hours.last,
              );
            }).toList(),
          ),

          // 🔥 Linha da hora atual
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
// UMA LINHA DE HORA (APENAS 1 COLUNA, UM DIA)
// -------------------------------------------------------------------------
class _DayHourRow extends StatelessWidget {
  final String hourLabel;
  final bool isLastRow;

  const _DayHourRow({
    super.key,
    required this.hourLabel,
    required this.isLastRow,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CalendarGridController.rowHeight,
      child: Row(
        children: [
          // LABEL DA HORA
          SizedBox(
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

          // LINHA (GRID)
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: isLastRow
                      ? BorderSide.none
                      : BorderSide(
                    color: Colors.white.withOpacity(0.55),
                    width: 1.2,
                  ),
                ),
              ),
              child: null,
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------------
// LINHA VERMELHA (HORA ATUAL)
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
