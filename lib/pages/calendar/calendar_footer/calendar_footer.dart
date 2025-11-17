import 'package:flutter/material.dart';
import '../add_activity/add_activity_sheet.dart';

class CalendarFooter extends StatelessWidget {
  const CalendarFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _AddActivityButton(),
      ],
    );
  }
}

class _AddActivityButton extends StatelessWidget {
  const _AddActivityButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: Container(
        // 🔥 Sombra suave estilo Bonded
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 14,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.12),
              blurRadius: 24,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: ElevatedButton.icon(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const AddActivitySheet(),
            );
          },

          icon: const Icon(Icons.add_rounded, size: 22),

          label: const Text(
            "Add Activity",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),

            backgroundColor: const Color(0xFF4E8EF6),
            foregroundColor: Colors.white,

            elevation: 0,
            shadowColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
