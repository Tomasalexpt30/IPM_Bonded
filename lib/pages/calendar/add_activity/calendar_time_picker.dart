import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarTimePicker extends StatefulWidget {
  final TimeOfDay? initialTime;

  const CalendarTimePicker({
    super.key,
    this.initialTime,
  });

  @override
  State<CalendarTimePicker> createState() => _BondedTimePickerState();
}

class _BondedTimePickerState extends State<CalendarTimePicker> {
  late int selectedHour;
  late int selectedMinute;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialTime?.hour ?? TimeOfDay.now().hour;
    selectedMinute = widget.initialTime?.minute ?? TimeOfDay.now().minute;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
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
            "Select Time",
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
                // HOUR PICKER
                SizedBox(
                  width: 80,
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                      initialItem: selectedHour,
                    ),
                    itemExtent: 38,
                    onSelectedItemChanged: (v) {
                      setState(() => selectedHour = v);
                    },
                    children: List.generate(
                      24,
                          (i) => Center(
                        child: Text(
                          i.toString().padLeft(2, '0'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const Text(
                  ":",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                // MINUTE PICKER
                SizedBox(
                  width: 80,
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                      initialItem: selectedMinute,
                    ),
                    itemExtent: 38,
                    onSelectedItemChanged: (v) {
                      setState(() => selectedMinute = v);
                    },
                    children: List.generate(
                      60,
                          (i) => Center(
                        child: Text(
                          i.toString().padLeft(2, '0'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

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
                    TimeOfDay(hour: selectedHour, minute: selectedMinute),
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
