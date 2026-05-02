import 'package:flutter/material.dart';
import 'package:deskrelief/features/auth/domain/models/user_model.dart';
import 'package:deskrelief/core/services/content_service.dart';
import 'package:deskrelief/features/content/domain/models/content_models.dart';

class DashboardViewModel extends ChangeNotifier {
  final ContentService _contentService = ContentService();
  String? _currentUid;
  UserModel? _currentUser;
  String _currentLocale = 'tr';

  void updateUser(UserModel? user) {
    if (user != null) {
      if (_currentUid != user.id) {
        _currentUid = user.id;
        _currentUser = user;
        notifyListeners();
      }
    } else {
      _currentUid = null;
      _currentUser = null;
      _isRestDay = true; 
      notifyListeners();
    }
  }

  void updateLocale(String langCode) {
    if (_currentLocale != langCode) {
      _currentLocale = langCode;
      notifyListeners();
    }
  }

  bool _isRestDay = true; 
  
  // Progress Data
  final double _progressValue = 0.8;
  final int _totalSessions = 5;

  bool get isRestDay => _isRestDay;
  double get progressValue => _progressValue;
  int get totalSessions => _totalSessions;
  int get completedSessions => (_progressValue * _totalSessions).toInt();
  int get remainingSessions => _totalSessions - completedSessions;

  // Content Service Data
  MotivationModel? get currentMotivation => _contentService.getRandomMotivation('screen_greetings');
  MotivationModel? get currentBct => _contentService.getRandomMotivation('exercise_continuity');

  
  List<ErgoTipModel> get recommendedTips {
    if (_currentUser == null) return [];
    final regionIds = _currentUser!.painRegions.map((r) => r.regionId).toList();
    return _contentService.getTipsForUser(regionIds);
  }

  List<BlogPostModel> get featuredBlogs => _contentService.getFeaturedBlogs();

  BlogPostModel? _featuredBlog;
  BlogPostModel? get randomFeaturedBlog {
    if (_featuredBlog == null && featuredBlogs.isNotEmpty) {
      _featuredBlog = (featuredBlogs..shuffle()).first;
    }
    return _featuredBlog;
  }


  void setRestDay(bool value) {
    _isRestDay = value;
    notifyListeners();
  }

  void toggleRestDay() {
    _isRestDay = !_isRestDay;
    notifyListeners();
  }

  String getFeedbackMessageKey() {
    if (_progressValue == 0) return 'feedbackStart';
    if (_progressValue < 0.3) return 'feedbackStep';
    if (_progressValue < 0.6) return 'feedbackHalfway';
    if (_progressValue < 1.0) return 'feedbackAlmostDone';
    return 'feedbackDone';
  }
}
