import 'package:flutter/material.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import '../../data/models/red_flag_question.dart';
import 'package:deskrelief/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:deskrelief/features/auth/domain/models/user_model.dart';

class RedFlagsViewModel extends ChangeNotifier {
  final AuthViewModel _authViewModel;

  RedFlagsViewModel({required AuthViewModel authViewModel}) : _authViewModel = authViewModel {
    loadInitialAnswers();
  }

  void loadInitialAnswers() {
    final user = _authViewModel.currentUser;
    _answers.clear();
    if (user != null && user.flaggedRedFlagIds.isNotEmpty) {
      for (var q in _questions) {
        if (user.flaggedRedFlagIds.contains(q.id.toString())) {
          _answers[q.id] = true;
        } else {
          _answers[q.id] = false;
        }
      }
    } else {
      // Initialize with false if no previous flags
      for (var q in _questions) {
        _answers[q.id] = false;
      }
    }
    notifyListeners();
  }

  int _currentStep = 1;
  int get currentStep => _currentStep;

  final Map<int, bool?> _answers = {};
  Map<int, bool?> get answers => _answers;

  final List<RedFlagQuestion> _questions = redFlagsMockData;
  List<RedFlagQuestion> get allQuestions => _questions;

  List<RedFlagQuestion> get currentStepQuestions =>
      _questions.where((q) => q.step == _currentStep).toList();

  bool get hasRedFlags {
    return _answers.values.any((answer) => answer == true);
  }

  String getCurrentCategoryTitle(BuildContext context) {
    final questionsInStep = currentStepQuestions;
    if (questionsInStep.isNotEmpty) {
      return questionsInStep.first.getCategoryTitle(AppLocalizations.of(context)!);
    }
    return '';
  }

  void setAnswer(int questionId, bool answer) {
    _answers[questionId] = answer;
    notifyListeners();
  }

  void nextStep(VoidCallback onCompleted) {
    if (_currentStep < 3) {
      _currentStep++;
      notifyListeners();
    } else {
      submit(onCompleted);
    }
  }

  void previousStep() {
    if (_currentStep > 1) {
      _currentStep--;
      notifyListeners();
    }
  }

  Future<void> submit(VoidCallback onCompleted) async {
    final flaggedIds = _answers.entries
        .where((e) => e.value == true)
        .map((e) => e.key.toString())
        .toList();

    if (flaggedIds.isNotEmpty) {
      // Kırmızı bayrak yakalandı: Banla
      await _authViewModel.updateUser(
        isBanned: true,
        banReason: BanReason.redFlag,
        flaggedRedFlagIds: flaggedIds,
      );
    } else {
      // Risk yok: Temizle ve ilerle
      await _authViewModel.updateUser(
        isBanned: false,
        banReason: null,
        flaggedRedFlagIds: [],
      );
    }

    onCompleted();
  }
}
