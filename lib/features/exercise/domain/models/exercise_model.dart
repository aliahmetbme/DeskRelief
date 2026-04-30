import 'package:flutter/foundation.dart';

enum ExercisePhase {
  mobilization,
  strengthening,
  stretching,
  coolDown,
}

class ExerciseItem {
  final String id;
  final String title;
  final ExercisePhase phase;
  final bool isLocked;
  final String imageUrl;
  final String? duration;
  final int? reps;
  final List<String> tags;
  final List<String> instructions;
  final List<String> warnings;
  final List<String> tips;
  final String focusArea;
  final String focusDescription;
  final String videoUrl;

  ExerciseItem({
    required this.id,
    required this.title,
    required this.phase,
    required this.isLocked,
    required this.imageUrl,
    this.duration,
    this.reps,
    this.tags = const [],
    this.instructions = const [],
    this.warnings = const [],
    this.tips = const [],
    this.focusArea = '',
    this.focusDescription = '',
    this.videoUrl = '',
  });
}
