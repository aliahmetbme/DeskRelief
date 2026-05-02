import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../assessment/data/services/cdss_service.dart';
import '../../data/services/auth_service.dart';
import '../../domain/models/user_model.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/clinical_alert_dialog.dart';
import '../../../../core/widgets/custom_toast.dart';
import 'package:go_router/go_router.dart';

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

  bool get isEmailVerified => _authService.currentUser?.emailVerified ?? false;
  String? get userEmail => _authService.currentUser?.email;

  AuthViewModel() {
    _init();
  }

  Future<void> _init() async {
    // 1. SharedPreferences verilerini çek
    final prefs = await SharedPreferences.getInstance();
    _hasSeenOnboarding = prefs.getBool('seenOnboarding') ?? false;
    notifyListeners();

    // 2. Yapay Bekleme Süresi (Splash kalıcılığı için)
    // Yeni animasyonun süresine (2.5 sn) uygun olarak ayarlandı
    await Future.delayed(const Duration(milliseconds: 2500));

    // 3. Auth Listener'ı kur
    _setupAuthListener();
  }

  
  StreamSubscription<UserModel?>? _userSubscription;

  void _setupAuthListener() {
    _authService.authStateChanges.listen((user) async {
      _userSubscription?.cancel();
      
      if (user != null) {
        _userSubscription = _authService.userStream(user.uid).listen((userData) {
          _currentUser = userData;
          _isInitialized = true;
          notifyListeners();
        }, onError: (e) {
          debugPrint("User Stream Error: $e");
          _isInitialized = true;
          notifyListeners();
        });
      } else {
        _currentUser = null;
        _isInitialized = true;
        notifyListeners();
      }
    });

    // Emniyet Mekanizması: Eğer internet çok kötüyse ve yukarıdaki await takılırsa zorla geç
    Future.delayed(const Duration(seconds: 4), () {
      if (!_isInitialized) {
        debugPrint("⏳ Splash timeout: Forcing initialization...");
        
        // YENİ: Eğer auth işlemi var ama db hala gelmediyse isInitialized'i true yapma
        if (_authService.currentUserId != null && _currentUser == null) {
          debugPrint("⏳ Ağ yavaş, Firestore bekleniyor. Splash'ta kalmaya devam et...");
          return; 
        }

        _isInitialized = true;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
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
      return '/body-map';
    } else if (!progress.hasCompletedPainScore) {
      return '/assessment/pain-intensity';
    } else if (!progress.hasCompletedScheduling) {
      return '/scheduling';
    }

    return '/home';
  }

  void checkClinicalStatus(BuildContext context, UserModel user) {
    if (!user.isBanned) {
      // Normal akışa devam et
      final route = checkUserProgress(user);
      GoRouter.of(context).go(route);
      return;
    }

    final loc = AppLocalizations.of(context)!;

    if (user.banReason == BanReason.redFlag) {
      // Senaryo A: Red Flag
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ClinicalAlertDialog(
          title: loc.dialogClinicalAlertTitle,
          message: loc.dialogRedFlagMessage,
          primaryButtonText: loc.btnUpdateSymptoms,
          secondaryButtonText: loc.btnCancel,
          isRedFlag: true,
          onPrimaryPressed: () {
            Navigator.pop(context);
            GoRouter.of(context).push('/red-flags');
          },
          onSecondaryPressed: () async {
            await signOut();
            if (context.mounted) {
              Navigator.pop(context);
              GoRouter.of(context).go('/sign-in');
            }
          },
        ),
      );
    } else {
      // Senaryo B: Genel Klinik Veto
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ClinicalAlertDialog(
          title: loc.dialogClinicalAlertTitle,
          message: loc.dialogGeneralVetoMessage,
          primaryButtonText: loc.btnDoctorApproved,
          secondaryButtonText: loc.btnCancel,
          isRedFlag: false,
          onPrimaryPressed: () async {
            // Süreci Sıfırla
            final updatedProgress = user.progress.copyWith(
              hasCompletedWelcome: false,
              hasCompletedRedFlags: false,
              hasCompletedBodyMap: false,
              hasCompletedPainScore: false,
              hasCompletedScheduling: false,
              isClearedForExercise: false,
            );

            final updatedUser = user.copyWith(
              isBanned: false,
              banReason: null,
              banNote: null,
              progress: updatedProgress,
            );

            await _authService.updateUser(updatedUser);
            await refreshCurrentUser();

            if (context.mounted) {
              Navigator.pop(context);
              GoRouter.of(context).go('/welcome-profile');
            }
          },
          onSecondaryPressed: () async {
            CustomToast.show(context, loc.toastSafetyWarning, isError: true);
            await signOut();
            if (context.mounted) {
              Navigator.pop(context);
              GoRouter.of(context).go('/sign-in');
            }
          },
        ),
      );
    }
  }

  Future<void> refreshCurrentUser() async {
    final uid = _authService.currentUserId;
    if (uid != null) {
      _currentUser = await _authService.getUserModel(uid);
      notifyListeners();
    }
  }

  /// Kullanıcı modelini genel olarak günceller ve Firestore'a yansıtır
  Future<void> updateUser({
    bool? isBanned,
    BanReason? banReason,
    List<String>? flaggedRedFlagIds,
    RegistrationProgress? progress,
    List<RegionDetail>? painRegions,
    String? gender,
    String? job,
    double? height,
    double? weight,
    bool? isSedentary,
  }) async {
    if (_currentUser == null) return;

    final newUser = _currentUser!.copyWith(
      isBanned: isBanned ?? _currentUser!.isBanned,
      banReason: banReason ?? _currentUser!.banReason,
      flaggedRedFlagIds: flaggedRedFlagIds ?? _currentUser!.flaggedRedFlagIds,
      progress: progress ?? _currentUser!.progress,
      painRegions: painRegions ?? _currentUser!.painRegions,
      gender: gender ?? _currentUser!.gender,
      job: job ?? _currentUser!.job,
      height: height ?? _currentUser!.height,
      weight: weight ?? _currentUser!.weight,
      isSedentary: isSedentary ?? _currentUser!.isSedentary,
    );

    await _authService.updateUser(newUser);
    await refreshCurrentUser();
  }

  Future<void> updateProgress({
    bool? hasCompletedWelcome,
    bool? hasCompletedRedFlags,
    bool? hasCompletedBodyMap,
    bool? hasCompletedPainScore,
    bool? hasCompletedScheduling,
    bool? isClearedForExercise,
    List<RegionDetail>? painRegions,
    String? gender,
  }) async {
    if (_currentUser == null) return;

    final currentProgress = _currentUser!.progress;
    final newProgress = currentProgress.copyWith(
      hasCompletedWelcome:
          hasCompletedWelcome ?? currentProgress.hasCompletedWelcome,
      hasCompletedRedFlags:
          hasCompletedRedFlags ?? currentProgress.hasCompletedRedFlags,
      hasCompletedBodyMap:
          hasCompletedBodyMap ?? currentProgress.hasCompletedBodyMap,
      hasCompletedPainScore:
          hasCompletedPainScore ?? currentProgress.hasCompletedPainScore,
      hasCompletedScheduling:
          hasCompletedScheduling ?? currentProgress.hasCompletedScheduling,
      isClearedForExercise:
          isClearedForExercise ?? currentProgress.isClearedForExercise,
    );

    final newUser = _currentUser!.copyWith(
      progress: newProgress,
      painRegions: painRegions ?? _currentUser!.painRegions,
      gender: gender ?? _currentUser!.gender,
    );

    await _authService.updateUser(newUser);
    await refreshCurrentUser();
    
    // YENİ: Klinik Güvenlik Kontrolü (CDSS)
    await performClinicalCheck();
  }

  /// Belirli bir nedenle kullanıcıyı manuel olarak banlar (Örn: Profildeki Red Flag değişikliği)
  Future<void> applyManualBan(BanReason reason) async {
    if (_currentUser == null) return;
    
    final bannedUser = _currentUser!.copyWith(
      isBanned: true,
      banReason: reason,
      banNote: "Kullanıcı profil ayarlarında Red Flag saptandı.",
    );

    await _authService.updateUser(bannedUser);
    await refreshCurrentUser();
  }

  /// CDSS Algoritmasını çalıştırır ve gerekirse kullanıcıyı banlar
  Future<void> performClinicalCheck() async {
    if (_currentUser == null || _currentUser!.isBanned) return;

    final reason = CDSSService.checkForClinicalBlock(_currentUser!);
    
    if (reason != null) {
      final bannedUser = _currentUser!.copyWith(
        isBanned: true,
        banReason: reason,
        banNote: "CDSS tarafından otomatik olarak atanmıştır.",
      );
      
      await _authService.updateUser(bannedUser);
      await refreshCurrentUser();
    }
  }

  Future<void> reloadUser() async {
    await _authService.reloadUser();
    notifyListeners();
  }

  Future<void> sendEmailVerification() async {
    await _authService.sendEmailVerification();
  }

  Future<bool> resetPassword(String email, AppLocalizations loc) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.sendPasswordResetEmail(email);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      // Firebase özel hataları için mapleme yapılabilir, şimdilik direkt mesajı alıyoruz
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
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

  Future<bool> signIn(
    String email,
    String password,
    AppLocalizations loc,
  ) async {
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

    notifyListeners();
    return true;
  }

  Future<bool> signUp(
    String name,
    String email,
    String password,
    AppLocalizations loc,
  ) async {
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

    // E-posta doğrulama linki gönder
    await _authService.sendEmailVerification();

    notifyListeners();
    return true;
  }

  Future<bool> signInWithGoogle(
    AppLocalizations loc, {
    bool isSignUp = false,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final error = await _authService.signInWithGoogle(
      loc: loc,
      isSignUp: isSignUp,
    );

    _isLoading = false;
    if (error == "CANCELED_BY_USER") {
      notifyListeners();
      return false;
    }
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

    notifyListeners();
    return true;
  }

  Future<bool> signInWithApple(
    AppLocalizations loc, {
    bool isSignUp = false,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final error = await _authService.signInWithApple(
      loc: loc,
      isSignUp: isSignUp,
    );

    _isLoading = false;
    if (error == "CANCELED_BY_USER") {
      notifyListeners();
      return false;
    }
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

    notifyListeners();
    return true;
  }
}
