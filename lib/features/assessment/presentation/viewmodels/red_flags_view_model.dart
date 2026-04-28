import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import '../../data/models/red_flag_question.dart';

class RedFlagsViewModel extends ChangeNotifier {
  RedFlagsViewModel() {
    _loadAnswers();
  }

  Future<void> _loadAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    for (var q in _questions) {
      final key = 'red_flag_${q.id}';
      if (prefs.containsKey(key)) {
        _answers[q.id] = prefs.getBool(key);
      } else {
        // Initial defaults if never set
        _answers[q.id] = false;
      }
    }
    notifyListeners();
  }

  Future<void> _saveAnswer(int id, bool val) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('red_flag_$id', val);
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
    _saveAnswer(questionId, answer);
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

  void submit(VoidCallback onCompleted) {
    // Burada sunucuya gönderme veya hesaplama yapılabilir.
    onCompleted();
  }
}
