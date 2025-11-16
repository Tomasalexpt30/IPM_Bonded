import 'package:flutter/material.dart';

class CalendarFooter extends StatelessWidget {
  const CalendarFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _FilterTile(
          label: "Show only Sofia’s activities",
          color: Color(0xFF22C55E),
        ),
        SizedBox(height: 8),
        _FilterTile(
          label: "Show only Daniel’s activities",
          color: Color(0xFF3B82F6),
        ),
        SizedBox(height: 8),
        _FilterTile(
          label: "Show both",
          color: Color(0xFFE11D48),
        ),
        SizedBox(height: 20),
        _AddActivityButton(),
      ],
    );
  }
}

class _FilterTile extends StatelessWidget {
  final String label;
  final Color color;

  const _FilterTile({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 13.5),
          ),
        ],
      ),
    );
  }
}

class _AddActivityButton extends StatelessWidget {
  const _AddActivityButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          "Add Activity",
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 4,
          backgroundColor: const Color(0xFF6366F1),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
