import 'package:flutter/material.dart';

class CalendarGridController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  static const double minRowHeight = 32;
  static const double maxRowHeight = 84;

  double _rowHeight = 64;
  double get rowHeight => _rowHeight;

  void updateRowHeight(double scale) {
    final newHeight =
    (_rowHeight * scale).clamp(minRowHeight, maxRowHeight);

    if (newHeight != _rowHeight) {
      _rowHeight = newHeight;
      notifyListeners();
    }
  }

  void scrollToCurrentHour() {
    final now = TimeOfDay.now();
    final offset =
        (now.hour + now.minute / 60) * _rowHeight;

    Future.delayed(const Duration(milliseconds: 120), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(offset);
      }
    });
  }

  double getCurrentHourOffset() {
    final now = TimeOfDay.now();
    return (now.hour + now.minute / 60) * _rowHeight;
  }
}
