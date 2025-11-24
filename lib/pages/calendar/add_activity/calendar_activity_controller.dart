import 'package:flutter/material.dart';

class CalendarActivity {
  final String id;
  final String name;
  final String category;
  final bool isCouple;
  final DateTime start;
  final DateTime end;
  final String? note;

  CalendarActivity({
    required this.id,
    required this.name,
    required this.category,
    required this.start,
    required this.end,
    required this.isCouple,
    this.note,
  });

  double get durationHours =>
      end.difference(start).inMinutes / 60;

  CalendarActivity copyWith({
    String? name,
    String? category,
    bool? isCouple,
    DateTime? start,
    DateTime? end,
    String? note,
  }) {
    return CalendarActivity(
      id: id,
      name: name ?? this.name,
      category: category ?? this.category,
      isCouple: isCouple ?? this.isCouple,
      start: start ?? this.start,
      end: end ?? this.end,
      note: note ?? this.note,
    );
  }
}

class CalendarActivityController extends ChangeNotifier {
  final List<CalendarActivity> _activities = [];

  List<CalendarActivity> get activities => List.unmodifiable(_activities);

  void addActivity(CalendarActivity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  List<CalendarActivity> getActivitiesForDay(DateTime day) {
    return _activities.where((a) =>
    a.start.year == day.year &&
        a.start.month == day.month &&
        a.start.day == day.day).toList();
  }

  void updateActivity(CalendarActivity updated) {
    final index = _activities.indexWhere((a) => a.id == updated.id);

    if (index != -1) {
      _activities[index] = updated;
      notifyListeners();
    }
  }

  void deleteActivity(CalendarActivity activity) {
    _activities.removeWhere((a) => a.id == activity.id);
    notifyListeners();
  }
}
