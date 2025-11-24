import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Activity model/controller
import 'calendar_activity_controller.dart';

// Custom Bonded pickers
import '../add_activity/calendar_time_picker.dart';
import '../add_activity/calendar_date_picker.dart';

// 🔥 FEEDBACK VISUAL
import '../feedback/calendar_feedback.dart';


class AddActivitySheet extends StatefulWidget {
  const AddActivitySheet({super.key});

  @override
  State<AddActivitySheet> createState() => _AddActivitySheetState();
}

class _AddActivitySheetState extends State<AddActivitySheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  String? selectedCategory;
  bool isCouple = false;

  // ERROR STATE MAP
  Map<String, String?> errors = {
    "name": null,
    "category": null,
    "date": null,
    "start": null,
    "end": null,
  };

  final List<String> categories = [
    "Date", "Gym", "Spa", "Work", "Study", "Travel", "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 45,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const Text(
              "Add Activity",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87),
            ),

            const SizedBox(height: 22),

            // NAME ===============================================
            const Text("Activity Name",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _input(nameController, "Enter Activity Name"),
            _errorText(errors["name"]),
            const SizedBox(height: 18),

            // CATEGORY ==========================================
            const Text("Category",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _dropdownCategory(),
            _errorText(errors["category"]),
            const SizedBox(height: 18),

            // DATE & TIME =======================================
            const Text("Date & Time",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(child: _datePicker()),
                const SizedBox(width: 8),
                Expanded(child: _timePicker("Start", startTime, true)),
                const SizedBox(width: 8),
                Expanded(child: _timePicker("Finish", endTime, false)),
              ],
            ),

            Row(
              children: [
                Expanded(child: _errorText(errors["date"])),
                const SizedBox(width: 8),
                Expanded(child: _errorText(errors["start"])),
                const SizedBox(width: 8),
                Expanded(child: _errorText(errors["end"])),
              ],
            ),

            const SizedBox(height: 20),

            // PARTICIPANT ========================================
            const Text("Participant",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _participantButton(
                    selected: !isCouple,
                    icon: Icons.person_outline_rounded,
                    label: "Individual",
                    onTap: () => setState(() => isCouple = false),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _participantButton(
                    selected: isCouple,
                    icon: Icons.people_alt_rounded,
                    label: "Couple",
                    onTap: () => setState(() => isCouple = true),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // NOTE ===============================================
            const Text("Note",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _input(noteController, "Add Note", maxLines: 3),
            const SizedBox(height: 26),

            // BUTTONS ============================================
            Row(
              children: [
                Expanded(
                  child: _button(
                    label: "Cancel",
                    background: Colors.white,
                    textColor: Colors.black87,
                    border: BorderSide(color: Colors.black.withOpacity(0.25)),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _button(
                    label: "Save",
                    background: const Color(0xFF2563EB),
                    textColor: Colors.white,
                    onTap: _validateAndSave,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // VALIDATION + CREATION
  // ===========================================================

  void _validateAndSave() {
    setState(() {
      errors["name"] = nameController.text.isEmpty ? "Required field" : null;
      errors["category"] =
      selectedCategory == null ? "Select a category" : null;
      errors["date"] = selectedDate == null ? "Select a date" : null;
      errors["start"] = startTime == null ? "Select start time" : null;
      errors["end"] = endTime == null ? "Select end time" : null;

      if (startTime != null && endTime != null) {
        final startDT = DateTime(0, 1, 1, startTime!.hour, startTime!.minute);
        final endDT = DateTime(0, 1, 1, endTime!.hour, endTime!.minute);

        if (endDT.isBefore(startDT)) {
          errors["end"] = "End must be after start";
        }
      }
    });

    if (errors.values.any((e) => e != null)) return;

    final activity = CalendarActivity(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: nameController.text.trim(),
      category: selectedCategory!,
      isCouple: isCouple,
      start: DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        startTime!.hour,
        startTime!.minute,
      ),
      end: DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        endTime!.hour,
        endTime!.minute,
      ),
      note: noteController.text.trim(),
    );

    // ⬇️ FEEDBACK BONDED
    CalendarFeedback.show(context, "Activity added!");

    Navigator.pop(context, activity);
  }

  // ===========================================================
  // COMPONENTS
  // ===========================================================

  Widget _errorText(String? text) {
    if (text == null) return const SizedBox(height: 18);

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _input(TextEditingController controller, String hint,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF4F6FA),
        hintText: hint,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _dropdownCategory() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          hint: const Text("Select Category"),
          items: categories
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
          onChanged: (value) => setState(() => selectedCategory = value),
        ),
      ),
    );
  }

  // ========== DATE PICKER ===============================
  Widget _datePicker() {
    return GestureDetector(
      onTap: () async {
        final picked = await showModalBottomSheet<DateTime>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) =>
              CalendarDatePickerBonded(initialDate: selectedDate),
        );

        if (picked != null) setState(() => selectedDate = picked);
      },
      child: _pickerBox(
        selectedDate != null
            ? DateFormat("dd/MM/yyyy").format(selectedDate!)
            : "dd/mm/yyyy",
      ),
    );
  }

  // ========== TIME PICKER ===============================
  Widget _timePicker(String label, TimeOfDay? time, bool isStart) {
    return GestureDetector(
      onTap: () async {
        final picked = await showModalBottomSheet<TimeOfDay>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => CalendarTimePicker(initialTime: time),
        );

        if (picked != null) {
          setState(() {
            if (isStart) {
              startTime = picked;
            } else {
              endTime = picked;
            }
          });
        }
      },
      child: _pickerBox(
          time != null ? time.format(context) : label),
    );
  }

  Widget _pickerBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style:
        const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _participantButton({
    required bool selected,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF2563EB) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? Colors.transparent : Colors.black26,
          ),
          boxShadow: selected
              ? [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 3),
            )
          ]
              : [],
        ),
        child: Column(
          children: [
            Icon(icon, color: selected ? Colors.white : Colors.black87),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button({
    required String label,
    required Color background,
    required Color textColor,
    VoidCallback? onTap,
    BorderSide? border,
  }) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: border ?? BorderSide.none,
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: const TextStyle(
              fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
    );
  }
}
