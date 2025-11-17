import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle (linha pequena no topo)
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
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),

          // -------------------- Activity Name --------------------
          const Text(
            "Activity Name",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          _input(nameController, "Enter Activity Name"),
          const SizedBox(height: 18),

          // -------------------- Category --------------------
          const Text(
            "Category",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          _dropdownCategory(),
          const SizedBox(height: 18),

          // -------------------- Date & Time --------------------
          const Text(
            "Date & Time",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
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
          const SizedBox(height: 20),

          // -------------------- Participants --------------------
          const Text(
            "Participant",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              // INDIVIDUAL
              Expanded(
                child: _participantButton(
                  selected: !isCouple,
                  icon: Icons.person_outline_rounded,
                  label: "Individual",
                  onTap: () => setState(() => isCouple = false),
                ),
              ),
              const SizedBox(width: 10),

              // COUPLE
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

          // -------------------- Note --------------------
          const Text(
            "Note",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          _input(noteController, "Add Note", maxLines: 3),
          const SizedBox(height: 26),

          // -------------------- Buttons --------------------
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
                  background: const Color(0xFF4E8EF6),
                  textColor: Colors.white,
                  onTap: () {
                    // 🔥 Aqui guardas a atividade !
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // ======================================================
  // COMPONENTES
  // ======================================================

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

  Widget _datePicker() {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
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

  Widget _timePicker(String label, TimeOfDay? time, bool isStart) {
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
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
      child: _pickerBox(time != null ? time.format(context) : label),
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
          color: selected ? const Color(0xFF4E8EF6) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color:
            selected ? Colors.transparent : Colors.black.withOpacity(0.2),
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
            Icon(
              icon,
              color: selected ? Colors.white : Colors.black87,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : Colors.black87,
              ),
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
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
    );
  }
}
