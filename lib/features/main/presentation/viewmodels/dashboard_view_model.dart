import 'package:flutter/material.dart';

class DashboardViewModel extends ChangeNotifier {
  bool _isRestDay = true; // Defaulting to true for testing the new UI as requested

  bool get isRestDay => _isRestDay;

  void setRestDay(bool value) {
    _isRestDay = value;
    notifyListeners();
  }

  void toggleRestDay() {
    _isRestDay = !_isRestDay;
    notifyListeners();
  }
}
