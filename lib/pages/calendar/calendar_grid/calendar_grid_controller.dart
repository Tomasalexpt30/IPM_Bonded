import 'package:flutter/material.dart';

class CalendarGridController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  /// Altura real de cada linha (contando padding)
  static const double rowHeight = 64;

  /// Faz scroll automaticamente até à hora atual
  void scrollToCurrentHour() {
    final now = TimeOfDay.now();
    final double offset = now.hour * rowHeight + (now.minute / 60) * rowHeight;

    Future.delayed(const Duration(milliseconds: 120), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(offset);
      }
    });
  }

  /// Posição da linha da hora atual dentro do conteúdo scroll
  double getCurrentHourOffset() {
    final now = TimeOfDay.now();
    return now.hour * rowHeight + (now.minute / 60) * rowHeight;
  }
}
