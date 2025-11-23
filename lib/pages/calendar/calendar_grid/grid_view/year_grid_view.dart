import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YearGridView extends StatelessWidget {
  final DateTime date;

  const YearGridView({super.key, required this.date});

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
              return _MonthCard(
                date: DateTime(date.year, index + 1, 1),
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
  const _MonthCard({required this.date});

  @override
  Widget build(BuildContext context) {
    final int year = date.year;
    final int month = date.month;

    final String title = DateFormat("MMMM").format(date);
    final int daysInMonth = DateUtils.getDaysInMonth(year, month);

    // 🔹 Monday=1 → 0; ...; Sunday=7 → 6
    final int firstWeekday = DateTime(year, month, 1).weekday - 1;

    List<int?> days = List<int?>.filled(firstWeekday, null, growable: true);
    for (int i = 1; i <= daysInMonth; i++) days.add(i);
    while (days.length % 7 != 0) days.add(null);

    const weekLetters = ["M", "T", "W", "T", "F", "S", "S"];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 14),

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

                final bool isToday = day != null &&
                    DateTime.now().year == year &&
                    DateTime.now().month == month &&
                    DateTime.now().day == day;

                return Center(
                  child: day == null
                      ? const SizedBox()
                      : Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isToday
                          ? Color(0xFF2563EB).withOpacity(0.85)
                          : null,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "$day",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isToday
                              ? FontWeight.w700
                              : FontWeight.w600,
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
