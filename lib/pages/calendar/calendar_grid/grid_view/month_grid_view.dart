import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthGridView extends StatelessWidget {
  final DateTime date;

  const MonthGridView({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final int year = date.year;
    final int month = date.month;

    final DateTime firstDay = DateTime(year, month, 1);

    // 🔹 Monday=1 → 0; Tuesday=2 → 1; ...; Sunday=7 → 6
    final int firstWeekday = firstDay.weekday - 1;

    final int daysInMonth = DateUtils.getDaysInMonth(year, month);

    // Lista growable com dias vazios antes do dia 1
    final List<int?> cells =
    List<int?>.filled(firstWeekday, null, growable: true);

    // Dias do mês
    for (int i = 1; i <= daysInMonth; i++) {
      cells.add(i);
    }

    // Completar até múltiplo de 7
    while (cells.length % 7 != 0) {
      cells.add(null);
    }

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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            DateFormat("MMMM yyyy").format(date),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                .map(
                  (d) => Expanded(
                child: Center(
                  child: Text(
                    d,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            )
                .toList(),
          ),

          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cells.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final day = cells[index];
              final bool isToday = day != null &&
                  DateTime.now().year == year &&
                  DateTime.now().month == month &&
                  DateTime.now().day == day;

              return Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: BoxDecoration(
                    color: day == null
                        ? Colors.transparent
                        : isToday
                        ? Colors.blueAccent.withOpacity(0.65)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: day != null
                        ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                        : [],
                  ),
                  child: day == null
                      ? null
                      : Center(
                    child: Text(
                      "$day",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                        isToday ? FontWeight.w700 : FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
