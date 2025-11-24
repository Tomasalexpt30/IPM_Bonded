import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarHeaderController extends ChangeNotifier {
  String _selectedSort = "Week";
  String get selectedSort => _selectedSort;

  void changeSort(String newSort) {
    _selectedSort = newSort;
    notifyListeners();
  }

  DateTime _currentDate = DateTime.now();
  DateTime get currentDate => _currentDate;
  void next() {
    switch (_selectedSort) {
      case "Day":
        _currentDate = _currentDate.add(const Duration(days: 1));
        break;

      case "Week":
        _currentDate = _currentDate.add(const Duration(days: 7));
        break;

      case "Month":
        _currentDate = DateTime(
          _currentDate.year,
          _currentDate.month + 1,
          _currentDate.day,
        );
        break;

      case "Year":
        _currentDate = DateTime(
          _currentDate.year + 1,
          _currentDate.month,
          _currentDate.day,
        );
        break;
    }

    notifyListeners();
  }

  void previous() {
    switch (_selectedSort) {
      case "Day":
        _currentDate = _currentDate.subtract(const Duration(days: 1));
        break;

      case "Week":
        _currentDate = _currentDate.subtract(const Duration(days: 7));
        break;

      case "Month":
        _currentDate = DateTime(
          _currentDate.year,
          _currentDate.month - 1,
          _currentDate.day,
        );
        break;

      case "Year":
        _currentDate = DateTime(
          _currentDate.year - 1,
          _currentDate.month,
          _currentDate.day,
        );
        break;
    }

    notifyListeners();
  }

  String get displayRange {
    switch (_selectedSort) {
      case "Day":
        return DateFormat("dd MMM yyyy").format(_currentDate);

      case "Week":
        final start = _currentDate.subtract(
            Duration(days: _currentDate.weekday - 1));
        final end = start.add(const Duration(days: 6));

        return "${DateFormat('dd MMM').format(start)} – "
            "${DateFormat('dd MMM').format(end)}";

      case "Month":
        return DateFormat("MMMM yyyy").format(_currentDate);

      case "Year":
        return _currentDate.year.toString();
    }

    return "";
  }
}
