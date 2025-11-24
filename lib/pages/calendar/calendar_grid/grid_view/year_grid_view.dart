import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// 🔥 ADICIONADO — actividades
import '../../add_activity/calendar_activity_controller.dart';

class YearGridView extends StatelessWidget {
  final DateTime date;

  // 🔥 ADICIONADO
  final CalendarActivityController activities;

  const YearGridView({
    super.key,
    required this.date,
    required this.activities,
  });

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
            color: Colors.blueGrey.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            date.year.toString(),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 26),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 26,
              crossAxisSpacing: 22,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              final monthDate = DateTime(date.year, index + 1, 1);

              return _MonthCard(
                date: monthDate,

                // 🔥 ADICIONADO
                activities: activities,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MonthCard extends StatelessWidget {
  final DateTime date;

  // 🔥 ADICIONADO
  final CalendarActivityController activities;

  const _MonthCard({
    required this.date,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    final int year = date.year;
    final int month = date.month;

    final String title = DateFormat("MMMM").format(date);

    final int daysInMonth = DateUtils.getDaysInMonth(year, month);

    // 🔥 TEM ALGUMA ATIVIDADE NO MÊS?
    final bool hasAnyActivity = List.generate(
      daysInMonth,
          (i) => activities.getActivitiesForDay(DateTime(year, month, i + 1)),
    ).any((list) => list.isNotEmpty);

    // 🔥 MÊS ATUAL?
    final bool isCurrentMonth =
        DateTime.now().month == month && DateTime.now().year == year;

    // Gere estrutura dos dias
    final int firstWeekday = DateTime(year, month, 1).weekday - 1;

    List<int?> days = List<int?>.filled(firstWeekday, null, growable: true);
    for (int i = 1; i <= daysInMonth; i++) days.add(i);
    while (days.length % 7 != 0) days.add(null);

    const weekLetters = ["M", "T", "W", "T", "F", "S", "S"];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        // 🔥 DESTACAR MESES COM ATIVIDADE
        border: hasAnyActivity
            ? Border.all(color: const Color(0xFF2563EB), width: 2)
            : null,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TÍTULO DO MÊS
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isCurrentMonth
                  ? const Color(0xFF2563EB)
                  : Colors.black87,
            ),
          ),

          const SizedBox(height: 14),

          // LETRAS DOS DIAS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekLetters
                .map(
                  (l) => Expanded(
                child: Center(
                  child: Text(
                    l,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            )
                .toList(),
          ),

          const SizedBox(height: 10),

          // GRID DE DIAS
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: days.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.25,
              ),
              itemBuilder: (context, index) {
                final day = days[index];

                if (day == null) {
                  return const SizedBox();
                }

                final bool isToday =
                    DateTime.now().year == year &&
                        DateTime.now().month == month &&
                        DateTime.now().day == day;

                final bool hasActivity =
                    activities.getActivitiesForDay(DateTime(year, month, day))
                        .isNotEmpty;

                return Center(
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isToday
                          ? const Color(0xFF2563EB)
                          : hasActivity
                          ? const Color(0xFF2563EB).withOpacity(0.25)
                          : null,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "$day",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight:
                          isToday ? FontWeight.w700 : FontWeight.w600,
                          color: isToday
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
