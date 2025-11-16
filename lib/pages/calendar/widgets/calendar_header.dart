import 'package:flutter/material.dart';
import '../controller/calendar_header_controller.dart';

class CalendarHeader extends StatelessWidget {
  final CalendarHeaderController controller;

  const CalendarHeader({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ======================================================
            // 🔹 DATE NAVIGATION (Day / Week / Month / Year)
            // ======================================================
            Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: _boxStyle,
              child: Row(
                children: [
                  // PREVIOUS <<
                  GestureDetector(
                    onTap: controller.previous,
                    child: const Icon(Icons.chevron_left_rounded,
                        size: 22, color: Colors.black87),
                  ),

                  const SizedBox(width: 6),

                  // 🔵 RANGE DINÂMICO
                  Text(
                    controller.displayRange,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(width: 6),

                  // NEXT >>
                  GestureDetector(
                    onTap: controller.next,
                    child: const Icon(Icons.chevron_right_rounded,
                        size: 22, color: Colors.black87),
                  ),
                ],
              ),
            ),

            SizedBox(width: screenWidth * 0.03),

            // ======================================================
            // 🔹 SORT BUTTON
            // ======================================================
            GestureDetector(
              onTap: () => _openSortMenu(context),
              child: Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: _boxStyle,
                child: Row(
                  children: [
                    const Icon(Icons.sort_rounded,
                        size: 18, color: Colors.black87),
                    const SizedBox(width: 6),

                    // Sort by <highlight>
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Sort by ",
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text: controller.selectedSort,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2595DA),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ======================================================
  // 🔹 Shared Box Style
  // ======================================================
  BoxDecoration get _boxStyle => BoxDecoration(
    color: Colors.white.withOpacity(0.9),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.blueGrey.withOpacity(0.18),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // ======================================================
  // 🔹 Bottom Sheet (Sort Options)
  // ======================================================
  void _openSortMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Sort Calendar By",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              _sortOption(context, "Day", Icons.today_rounded),
              _sortOption(context, "Week", Icons.view_week_rounded),
              _sortOption(context, "Month", Icons.view_module_rounded),
              _sortOption(context, "Year", Icons.calendar_month_rounded),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // ======================================================
  // 🔹 Sort Option Tile
  // ======================================================
  Widget _sortOption(BuildContext context, String label, IconData icon) {
    final bool isSelected = (controller.selectedSort == label);

    return GestureDetector(
      onTap: () {
        controller.changeSort(label);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 24, color: const Color(0xFF2595DA)),
            const SizedBox(width: 14),

            Text(
              "Sort by $label",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const Spacer(),

            if (isSelected)
              const Icon(Icons.check_rounded,
                  size: 22, color: Color(0xFF2595DA)),
          ],
        ),
      ),
    );
  }
}
