import 'package:flutter/material.dart';
import 'package:deskrelief/features/auth/domain/models/user_model.dart';

class DashboardViewModel extends ChangeNotifier {
  String? _currentUid;

  void updateUser(UserModel? user) {
    if (user != null) {
      if (_currentUid != user.id) {
        _currentUid = user.id;
        notifyListeners();
      }
    } else {
      _currentUid = null;
      _isRestDay = true; 
      notifyListeners();
    }
  }

  bool _isRestDay = true; // Defaulting to true for testing the new UI as requested
  
  // Progress Data (In a real app, these would come from a repository)
  final double _progressValue = 0.8;
  final int _totalSessions = 5;

  bool get isRestDay => _isRestDay;
  double get progressValue => _progressValue;
  int get totalSessions => _totalSessions;
  int get completedSessions => (_progressValue * _totalSessions).toInt();
  int get remainingSessions => _totalSessions - completedSessions;

  void setRestDay(bool value) {
    _isRestDay = value;
    notifyListeners();
  }

  void toggleRestDay() {
    _isRestDay = !_isRestDay;
    notifyListeners();
  }

  /// Logic to determine feedback message based on progress
  String getFeedbackMessageKey() {
    if (_progressValue == 0) return 'feedbackStart';
    if (_progressValue < 0.3) return 'feedbackStep';
    if (_progressValue < 0.6) return 'feedbackHalfway';
    if (_progressValue < 1.0) return 'feedbackAlmostDone';
    return 'feedbackDone';
  }
}
