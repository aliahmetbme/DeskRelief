import 'package:flutter/material.dart';
import '../../domain/models/exercise_model.dart';
import '../../data/services/video_cache_service.dart';

class ExerciseDetailViewModel extends ChangeNotifier {
  final ExerciseItem exercise;
  final VideoCacheService _cacheService = VideoCacheService();

  ExerciseDetailViewModel({required this.exercise});

  String get cachedVideoUrl => _cacheService.getCachedUrl(exercise.videoUrl);

  Future<void> markAsCompleted(BuildContext context) async {
    // Simulate a delay for the process
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (context.mounted) {
      Navigator.of(context).pop(true);
    }
  }
}
