import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/red_flag_question.dart';
import 'package:deskrelief/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:deskrelief/features/auth/domain/models/user_model.dart';
import '../widgets/assessment_result_dialog.dart';

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

  Map<int, List<RedFlagQuestion>> get questionsByCategory {
    return {
      1: _questions.where((q) => q.step == 1).toList(),
      2: _questions.where((q) => q.step == 2).toList(),
      3: _questions.where((q) => q.step == 3).toList(),
    };
  }

  bool get hasRedFlags {
    return _answers.values.any((answer) => answer == true);
  }

  String getCurrentCategoryTitleKey() {
    final questionsInStep = currentStepQuestions;
    if (questionsInStep.isNotEmpty) {
      return questionsInStep.first.getCategoryTitleKey();
    }
    return '';
  }

  void setAnswer(int questionId, bool answer) {
    _answers[questionId] = answer;
    notifyListeners();
  }

  void nextStep(BuildContext context) {
    if (_currentStep < 3) {
      _currentStep++;
      notifyListeners();
    } else {
      submitRedFlags(context);
    }
  }

  void previousStep() {
    if (_currentStep > 1) {
      _currentStep--;
      notifyListeners();
    }
  }

  Future<void> submitRedFlags(BuildContext context) async {
    final flaggedIds = _answers.entries
        .where((e) => e.value == true)
        .map((e) => e.key.toString())
        .toList();

    if (flaggedIds.isNotEmpty) {
      await _authViewModel.updateUser(
        isBanned: true,
        banReason: BanReason.redFlag,
        flaggedRedFlagIds: flaggedIds,
      );
    } else {
      await _authViewModel.updateUser(
        isBanned: false,
        banReason: null,
        flaggedRedFlagIds: [],
      );
    }

    if (context.mounted) {
      _showResultDialog(context);
    }
  }

  void _showResultDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      pageBuilder: (context, animation, secondaryAnimation) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AssessmentResultDialog(
            hasRedFlags: hasRedFlags,
            onActionPressed: () async {
              if (hasRedFlags) {
                context.pop();
                context.go('/sign-in');
              } else {
                context.pop();
                await _authViewModel.updateProgress(hasCompletedRedFlags: true);
                if (context.mounted) {
                  context.go('/body-map');
                }
              }
            },
          ),
        );
      },
    );
  }

  Future<void> submitExclusionCriteria(BuildContext context) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      pageBuilder: (context, animation, secondaryAnimation) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AssessmentResultDialog(
            hasRedFlags: hasRedFlags,
            onActionPressed: () async {
              if (hasRedFlags) {
                await _authViewModel.applyManualBan(BanReason.redFlag);
                if (context.mounted) {
                  context.pop();
                }
              } else {
                context.pop();
                context.pop();
              }
            },
          ),
        );
      },
    );
  }
}
