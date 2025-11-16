import 'package:flutter/material.dart';

class CalendarGridController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  /// Faz scroll automaticamente até à hora atual ao abrir o calendário
  void scrollToCurrentHour() {
    final now = TimeOfDay.now().hour; // Ex: 15 significa 15:00
    const double rowHeight = 64; // 52 de card + 12 de spacing vertical approx
    final double targetOffset = now * rowHeight;

    Future.delayed(const Duration(milliseconds: 120), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(targetOffset);
      }
    });
  }
}
