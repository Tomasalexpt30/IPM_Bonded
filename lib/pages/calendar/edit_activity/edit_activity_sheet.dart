import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Activity model/controller
import '../add_activity/calendar_activity_controller.dart';

// Bonded pickers
import '../add_activity/calendar_time_picker.dart';
import '../add_activity/calendar_date_picker.dart';

class EditActivitySheet extends StatefulWidget {
  final CalendarActivity activity;
  final CalendarActivityController controller;

  const EditActivitySheet({
    super.key,
    required this.activity,
    required this.controller,
  });

  @override
  State<EditActivitySheet> createState() => _EditActivitySheetState();
}

class _EditActivitySheetState extends State<EditActivitySheet> {
  late TextEditingController nameController;
  late TextEditingController noteController;

  late DateTime selectedDate;
  late TimeOfDay startTime;
  late TimeOfDay endTime;

  late String selectedCategory;
  late bool isCouple;

  // validation errors
  Map<String, String?> errors = {
    "name": null,
    "category": null,
    "date": null,
    "start": null,
    "end": null,
  };

  final List<String> categories = [
    "Date",
    "Gym",
    "Spa",
    "Work",
    "Study",
    "Travel",
    "Other",
  ];

  @override
  void initState() {
    super.initState();
    final a = widget.activity;

    nameController = TextEditingController(text: a.name);
    noteController = TextEditingController(text: a.note ?? "");

    selectedDate = a.start;
    startTime = TimeOfDay(hour: a.start.hour, minute: a.start.minute);
    endTime = TimeOfDay(hour: a.end.hour, minute: a.end.minute);

    selectedCategory = a.category;
    isCouple = a.isCouple;
  }

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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Activity Details",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close_rounded, size: 26),
                )
              ],
            ),

            const SizedBox(height: 22),

            // NAME
            const Text("Activity Name",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _input(nameController, "Enter Activity Name"),
            _errorText(errors["name"]),
            const SizedBox(height: 18),

            // CATEGORY
            const Text("Category",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _dropdownCategory(),
            _errorText(errors["category"]),
            const SizedBox(height: 18),

            // DATE & TIMES
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

            // PARTICIPANTS
            const Text("Participant",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _participantButton(
                    selected: !isCouple,
                    label: "Individual",
                    icon: Icons.person_outline_rounded,
                    onTap: () => setState(() => isCouple = false),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _participantButton(
                    selected: isCouple,
                    label: "Couple",
                    icon: Icons.people_alt_rounded,
                    onTap: () => setState(() => isCouple = true),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // NOTE
            const Text("Note",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _input(noteController, "Add Note", maxLines: 3),

            const SizedBox(height: 26),

            // BUTTONS: DELETE + SAVE CHANGES
            Row(
              children: [
                Expanded(
                  child: _dangerButton(
                    label: "Delete",
                    color: Colors.redAccent,
                    onTap: () {
                      widget.controller.deleteActivity(widget.activity);
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _saveButton(
                    label: "Save Changes",
                    onTap: _validateAndSave,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // ======================================================
  // VALIDATION + SAVE
  // ======================================================

  void _validateAndSave() {
    setState(() {
      errors["name"] =
      nameController.text.trim().isEmpty ? "Required field" : null;
      errors["category"] =
      selectedCategory.isEmpty ? "Select category" : null;
      errors["date"] = selectedDate == null ? "Select date" : null;
      errors["start"] = startTime == null ? "Select start" : null;
      errors["end"] = endTime == null ? "Select end" : null;

      if (startTime != null && endTime != null) {
        final s = DateTime(0, 1, 1, startTime.hour, startTime.minute);
        final e = DateTime(0, 1, 1, endTime.hour, endTime.minute);
        if (e.isBefore(s)) errors["end"] = "End must be after start";
      }
    });

    if (errors.values.any((x) => x != null)) return;

    final updated = widget.activity.copyWith(
      name: nameController.text.trim(),
      note: noteController.text.trim(),
      category: selectedCategory,
      isCouple: isCouple,
      start: DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        startTime.hour,
        startTime.minute,
      ),
      end: DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        endTime.hour,
        endTime.minute,
      ),
    );

    widget.controller.updateActivity(updated);
    Navigator.pop(context);
  }

  // ======================================================
  // UI COMPONENTS
  // ======================================================

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
          items: categories
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
          onChanged: (v) => setState(() => selectedCategory = v!),
        ),
      ),
    );
  }

  // DATE PICKER (Bonded)
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
      child: _pickerBox(DateFormat("dd/MM/yyyy").format(selectedDate)),
    );
  }

  // TIME PICKER (Bonded)
  Widget _timePicker(String label, TimeOfDay time, bool isStart) {
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
      child: _pickerBox(time.format(context)),
    );
  }

  Widget _pickerBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FA),
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
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
            color: selected ? Colors.transparent : Colors.black.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: selected ? Colors.white : Colors.black87),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dangerButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(label,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
      ),
    );
  }

  Widget _saveButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(label,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
      ),
    );
  }
}
