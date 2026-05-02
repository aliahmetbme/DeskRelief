import 'dart:async';
import 'package:flutter/material.dart';
import 'package:deskrelief/features/auth/domain/models/user_model.dart';
import 'package:deskrelief/features/profile/data/repositories/profile_repository.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import 'package:deskrelief/core/widgets/custom_toast.dart';

class PersonalInfoViewModel extends ChangeNotifier {
  final ProfileRepository _profileRepository = ProfileRepositoryImpl();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  StreamSubscription<UserModel?>? _userSubscription;

  /// Bu metod AuthViewModel'den gelen kullanıcı bilgisini günceller ve stream'i başlatır.
  void updateUserData(UserModel? user) {
    if (user == null) {
      _currentUser = null;
      _userSubscription?.cancel();
      _userSubscription = null;
      notifyListeners();
      return;
    }

    if (_currentUser?.id != user.id) {
      _userSubscription?.cancel();
      _userSubscription = _profileRepository.getUserStream(user.id).listen((dbUser) {
        _currentUser = dbUser;
        notifyListeners();
      });
    }
    
    // Eğer stream henüz veri vermediyse başlangıç verisi olarak kullan
    if (_currentUser == null) {
      _currentUser = user;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }

  Future<void> updatePersonalInfo({
    required BuildContext context,
    String? job,
    String? gender,
    double? height,
    double? weight,
    bool? isSedentary,
  }) async {
    if (_currentUser == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final updatedUser = _currentUser!.copyWith(
        job: job ?? _currentUser!.job,
        gender: gender ?? _currentUser!.gender,
        height: height ?? _currentUser!.height,
        weight: weight ?? _currentUser!.weight,
        isSedentary: isSedentary ?? _currentUser!.isSedentary,
      );

      await _profileRepository.updateProfile(updatedUser);

      if (context.mounted) {
        final loc = AppLocalizations.of(context)!;
        CustomToast.show(context, loc.updateSuccess);
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        CustomToast.show(context, e.toString(), isError: true);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
