import 'package:flutter/material.dart';
import '../../data/models/red_flag_question.dart';

class RedFlagsViewModel extends ChangeNotifier {
  RedFlagsViewModel() {
    for (var q in _questions) {
      _answers[q.id] = false;
    }
  }
  int _currentStep = 1;
  int get currentStep => _currentStep;

  final Map<int, bool?> _answers = {};
  Map<int, bool?> get answers => _answers;

  final List<RedFlagQuestion> _questions = redFlagsMockData;

  List<RedFlagQuestion> get currentStepQuestions =>
      _questions.where((q) => q.step == _currentStep).toList();

  bool get hasRedFlags {
    return _answers.values.any((answer) => answer == true);
  }

  String get currentCategoryTitle {
    final questionsInStep = currentStepQuestions;
    if (questionsInStep.isNotEmpty) {
      return questionsInStep.first.categoryTitle;
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

  void submit(VoidCallback onCompleted) {
    // Burada sunucuya gönderme veya hesaplama yapılabilir.
    onCompleted();
  }
}
