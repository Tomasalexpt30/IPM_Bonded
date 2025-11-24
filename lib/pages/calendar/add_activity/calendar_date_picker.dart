import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarDatePickerBonded extends StatefulWidget {
  final DateTime? initialDate;

  const CalendarDatePickerBonded({
    super.key,
    this.initialDate,
  });

  @override
  State<CalendarDatePickerBonded> createState() =>
      _CalendarDatePickerBondedState();
}

class _CalendarDatePickerBondedState extends State<CalendarDatePickerBonded> {
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;

  final int minYear = 2020;
  final int maxYear = 2035;

  @override
  void initState() {
    super.initState();

    final now = widget.initialDate ?? DateTime.now();
    selectedDay = now.day;
    selectedMonth = now.month;
    selectedYear = now.year;
  }

  List<int> _daysInMonth(int month, int year) {
    final lastDay = DateTime(year, month + 1, 0).day;
    return List.generate(lastDay, (i) => i + 1);
  }

  @override
  Widget build(BuildContext context) {
    final days = _daysInMonth(selectedMonth, selectedYear);
    final months = List.generate(12, (i) => i + 1);
    final years = List.generate(maxYear - minYear + 1, (i) => minYear + i);

    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // handle
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const Text(
            "Select Date",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // DAY PICKER
                SizedBox(
                  width: 80,
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedDay - 1),
                    itemExtent: 38,
                    onSelectedItemChanged: (i) =>
                        setState(() => selectedDay = days[i]),
                    children: days
                        .map((d) => Center(
                      child: Text(
                        d.toString().padLeft(2, '0'),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                ),

                const Text(
                  "/",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                // MONTH PICKER
                SizedBox(
                  width: 90,
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedMonth - 1),
                    itemExtent: 38,
                    onSelectedItemChanged: (i) =>
                        setState(() => selectedMonth = months[i]),
                    children: months
                        .map((m) => Center(
                      child: Text(
                        DateFormat("MMM")
                            .format(DateTime(2024, m))
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                ),

                const Text(
                  "/",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                // YEAR PICKER
                SizedBox(
                  width: 90,
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedYear - minYear),
                    itemExtent: 38,
                    onSelectedItemChanged: (i) =>
                        setState(() => selectedYear = years[i]),
                    children: years
                        .map((y) => Center(
                      child: Text(
                        "$y",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Confirm button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                    DateTime(selectedYear, selectedMonth, selectedDay),
                  );
                },
                child: const Text(
                  "Confirm",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
