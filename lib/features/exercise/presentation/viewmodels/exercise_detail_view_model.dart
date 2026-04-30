import 'package:flutter/material.dart';
import '../../domain/models/exercise_model.dart';

class ExerciseDetailViewModel extends ChangeNotifier {
  final ExerciseItem exercise;

  ExerciseDetailViewModel({required this.exercise});

  Future<void> markAsCompleted(BuildContext context) async {
    // Simulate a delay for the process
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (context.mounted) {
      Navigator.of(context).pop(true);
    }
  }
}
