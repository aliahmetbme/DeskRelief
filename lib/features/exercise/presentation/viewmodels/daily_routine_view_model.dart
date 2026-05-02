import 'package:flutter/foundation.dart';
import '../../domain/models/exercise_model.dart';
import 'package:deskrelief/features/auth/domain/models/user_model.dart';
import '../../data/repositories/exercise_repository.dart';
import '../../../../core/error/result.dart';
import '../../../../core/services/content_service.dart';
import '../../../content/domain/models/content_models.dart';

class DailyRoutineViewModel extends ChangeNotifier {
  final ExerciseRepository _repository = ExerciseRepository();
  final ContentService _contentService = ContentService();
  
  String? _currentUid;
  UserModel? _currentUser;
  
  bool _isLoading = false;
  String? _errorMessage;
  List<ExerciseItem> _exercises = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ExerciseItem> get exercises => _exercises;

  void updateUser(UserModel? user) {
    if (user != null) {
      if (_currentUid != user.id) {
        _currentUid = user.id;
        _currentUser = user;
        loadExercises();
      }
    } else {
      _currentUid = null;
      _currentUser = null;
      _exercises = [];
      notifyListeners();
    }
  }

  Future<void> loadExercises() async {
    if (_currentUser == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final acuteRegionIds = _currentUser!.painRegions
        .where((r) => r.isAkut)
        .map((r) => r.regionId)
        .toList();

    final selectedRegions = _currentUser!.painRegions
        .map((r) => _mapStringToPainRegion(r.regionId))
        .whereType<PainRegion>()
        .toList();

    final result = await _repository.getExercisesForRegions(
      selectedRegions,
      acuteRegionIds: acuteRegionIds,
    );

    _isLoading = false;

    switch (result) {
      case Success(:final data):
        _exercises = data.map((model) => _mapToLegacyItem(model)).toList();
        break;
      case Failure(:final failure):
        _errorMessage = failure.message;
        break;
    }

    notifyListeners();
  }

  PainRegion? _mapStringToPainRegion(String id) {
    try {
      return PainRegion.values.firstWhere((e) => e.name == id);
    } catch (_) {
      return null;
    }
  }

  ExerciseItem _mapToLegacyItem(ExerciseModel model) {
    return ExerciseItem(
      id: model.id,
      title: model.name,
      phase: _mapToLegacyPhase(model.phase),
      isLocked: model.isLocked,
      imageUrl: model.imageUrl ?? '',
      duration: model.estimatedDurationSeconds != null 
          ? '${(model.estimatedDurationSeconds! / 60).round()} Dakika' 
          : null,
      reps: model.recommendedReps,
      tags: model.isJoker ? ['Ortak Bölge', 'Joker'] : [],
      instructions: model.steps,
      warnings: model.warnings,
      tips: model.tips,
      focusArea: model.targetRegions.map((e) => e.name).join(', '),
      focusDescription: model.description,
      videoUrl: model.videoUrl ?? '',
    );
  }

  LegacyExercisePhase _mapToLegacyPhase(ExercisePhase phase) {
    switch (phase) {
      case ExercisePhase.rom:
        return LegacyExercisePhase.mobilization;
      case ExercisePhase.strength:
        return LegacyExercisePhase.strengthening;
      case ExercisePhase.stretch:
        return LegacyExercisePhase.stretching;
    }
  }

  int get remainingExercisesCount => _exercises.where((e) => e.isLocked).length;

  Map<LegacyExercisePhase, List<ExerciseItem>> get exercisesByPhase {
    final Map<LegacyExercisePhase, List<ExerciseItem>> grouped = {};
    for (var phase in LegacyExercisePhase.values) {
      final phaseExercises = _exercises.where((e) => e.phase == phase).toList();
      if (phaseExercises.isNotEmpty) {
        grouped[phase] = phaseExercises;
      }
    }
    return grouped;
  }

  void onExerciseTap(ExerciseItem exercise) {
    if (exercise.isLocked) return;
  }

  MotivationModel? getCompletionMotivation() {
    return _contentService.getRandomMotivation('exercise_continuity');
  }
}
