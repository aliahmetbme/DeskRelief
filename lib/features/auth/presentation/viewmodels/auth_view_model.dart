import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/services/auth_service.dart';
import '../../domain/models/user_model.dart';
import '../../../../l10n/app_localizations.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool _hasSeenOnboarding = false;
  bool get hasSeenOnboarding => _hasSeenOnboarding;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  AuthViewModel() {
    _init();
    // Auth state changes dinleyici
    _authService.authStateChanges.listen((user) async {
      if (user != null) {
        // Kullanıcı var, verilerini çekmeye başla (ama akışı kilitleme)
        refreshCurrentUser().catchError((e) => debugPrint("Refresh error: $e"));
      } else {
        _currentUser = null;
      }
      
      // İlk sinyal geldiğinde veya kullanıcı yoksa direkt başlatıldı say
      if (!_isInitialized) {
        _isInitialized = true;
        notifyListeners();
      }
    });
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    _hasSeenOnboarding = prefs.getBool('seenOnboarding') ?? false;
    notifyListeners();
    
    // Emniyet Mekanizması: Eğer 3 saniye içinde kimseden ses çıkmazsa splash'i zorla geç
    Future.delayed(const Duration(seconds: 3), () {
      if (!_isInitialized) {
        debugPrint("⏳ Splash timeout: Forcing initialization...");
        _isInitialized = true;
        notifyListeners();
      }
    });
  }

  Future<void> setHasSeenOnboarding(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', value);
    _hasSeenOnboarding = value;
    notifyListeners();
  }

  String checkUserProgress(UserModel user) {
    if (user.isBanned) return '/clinical-block';

    final progress = user.progress;

    if (!progress.hasCompletedWelcome) {
      return '/welcome-profile';
    } else if (!progress.hasCompletedRedFlags) {
      return '/red-flags';
    } else if (!progress.hasCompletedBodyMap || user.painRegions.isEmpty) {
      // Not: hasCompletedBodyMap true olsa bile painRegions boşsa body-map'e geri gönder
      return '/body-map';
    } else if (!progress.hasCompletedPainScore) {
      return '/assessment/pain-intensity';
    } else if (!progress.hasCompletedScheduling) {
      return '/scheduling';
    }

    return '/home';
  }

  Future<void> refreshCurrentUser() async {
    final uid = _authService.currentUserId;
    if (uid != null) {
      _currentUser = await _authService.getUserModel(uid);
      notifyListeners();
    }
  }

  Future<void> updateProgress({
    bool? hasCompletedWelcome,
    bool? hasCompletedRedFlags,
    bool? hasCompletedBodyMap,
    bool? hasCompletedPainScore,
    bool? hasCompletedScheduling,
    bool? isClearedForExercise,
    List<RegionDetail>? painRegions,
  }) async {
    if (_currentUser == null) return;

    final currentProgress = _currentUser!.progress;
    final newProgress = currentProgress.copyWith(
      hasCompletedWelcome: hasCompletedWelcome ?? currentProgress.hasCompletedWelcome,
      hasCompletedRedFlags: hasCompletedRedFlags ?? currentProgress.hasCompletedRedFlags,
      hasCompletedBodyMap: hasCompletedBodyMap ?? currentProgress.hasCompletedBodyMap,
      hasCompletedPainScore: hasCompletedPainScore ?? currentProgress.hasCompletedPainScore,
      hasCompletedScheduling: hasCompletedScheduling ?? currentProgress.hasCompletedScheduling,
      isClearedForExercise: isClearedForExercise ?? currentProgress.isClearedForExercise,
    );

    final newUser = _currentUser!.copyWith(
      progress: newProgress,
      painRegions: painRegions ?? _currentUser!.painRegions,
    );
    
    await _authService.updateUser(newUser);
    await refreshCurrentUser();
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.signOut();
      _currentUser = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signIn(String email, String password, AppLocalizations loc) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final error = await _authService.signIn(
      email: email,
      password: password,
      loc: loc,
    );

    _isLoading = false;
    if (error != null) {
      _errorMessage = error;
      notifyListeners();
      return false;
    }

    if (_authService.currentUserId == null) {
      notifyListeners();
      return false;
    }

    await refreshCurrentUser();
    
    // Ban Kontrolü
    if (_currentUser != null && _currentUser!.isBanned) {
      await _authService.signOut();
      _currentUser = null;
      _errorMessage = loc.errorUserDisabled;
      notifyListeners();
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> signUp(String name, String email, String password, AppLocalizations loc) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final error = await _authService.signUp(
      name: name,
      email: email,
      password: password,
      loc: loc,
    );

    _isLoading = false;
    if (error != null) {
      _errorMessage = error;
      notifyListeners();
      return false;
    }

    if (_authService.currentUserId == null) {
      notifyListeners();
      return false;
    }

    await refreshCurrentUser();
    notifyListeners();
    return true;
  }

  Future<bool> signInWithGoogle(AppLocalizations loc, {bool isSignUp = false}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final error = await _authService.signInWithGoogle(loc: loc, isSignUp: isSignUp);

    _isLoading = false;
    if (error != null) {
      _errorMessage = error;
      notifyListeners();
      return false;
    }

    // null döndüyse: İptal mi yoksa Başarı mı?
    if (_authService.currentUserId == null) {
      notifyListeners();
      return false;
    }

    await refreshCurrentUser();
    
    // Ban Kontrolü
    if (_currentUser != null && _currentUser!.isBanned) {
      await _authService.signOut();
      _currentUser = null;
      _errorMessage = loc.errorUserDisabled;
      notifyListeners();
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> signInWithApple(AppLocalizations loc, {bool isSignUp = false}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final error = await _authService.signInWithApple(loc: loc, isSignUp: isSignUp);

    _isLoading = false;
    if (error != null) {
      _errorMessage = error;
      notifyListeners();
      return false;
    }

    // null döndüyse: İptal mi yoksa Başarı mı?
    if (_authService.currentUserId == null) {
      notifyListeners();
      return false;
    }

    await refreshCurrentUser();
    
    // Ban Kontrolü
    if (_currentUser != null && _currentUser!.isBanned) {
      await _authService.signOut();
      _currentUser = null;
      _errorMessage = loc.errorUserDisabled;
      notifyListeners();
      return false;
    }

    notifyListeners();
    return true;
  }
}
