import 'package:flutter/material.dart';

class CalendarGridController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  static const double rowHeight = 64;

  void scrollToCurrentHour() {
    final now = TimeOfDay.now();
    final double offset = now.hour * rowHeight + (now.minute / 60) * rowHeight;

    Future.delayed(const Duration(milliseconds: 120), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(offset);
      }
    });
  }

  double getCurrentHourOffset() {
    final now = TimeOfDay.now();
    return now.hour * rowHeight + (now.minute / 60) * rowHeight;
  }
}
