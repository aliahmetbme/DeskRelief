import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_model.freezed.dart';
part 'exercise_model.g.dart';

// ──────────────────────────────────────────────────────────────────────────────
// LEGACY ENUMS — kept for backward compatibility with existing UI layers
// (DailyRoutinePage, ExerciseDetailPage, etc.)
// ──────────────────────────────────────────────────────────────────────────────

enum LegacyExercisePhase {
  mobilization,
  strengthening,
  stretching,
  coolDown,
}

// ──────────────────────────────────────────────────────────────────────────────
// LEGACY MODEL — kept for backward compatibility with existing UI layers
// ──────────────────────────────────────────────────────────────────────────────

class ExerciseItem {
  final String id;
  final String title;
  final LegacyExercisePhase phase;
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

// ──────────────────────────────────────────────────────────────────────────────
// NEW DOMAIN LAYER — freezed models for the CDSS / Firestore exercise pipeline
// ──────────────────────────────────────────────────────────────────────────────

/// Clinical exercise phase used in Firestore documents.
enum ExercisePhase {
  @JsonValue('rom') rom,
  @JsonValue('strength') strength,
  @JsonValue('stretch') stretch,
}

/// Canonical clinical body regions used as Firestore filter keys.
/// UI-level region strings (e.g. "Sağ Arka Omuz") are mapped to these
/// values before any repository query is executed.
enum PainRegion {
  @JsonValue('neck') neck,
  @JsonValue('leftShoulder') leftShoulder,
  @JsonValue('rightShoulder') rightShoulder,
  @JsonValue('upperBack') upperBack,
  @JsonValue('lowerBack') lowerBack,
  @JsonValue('leftArm') leftArm,
  @JsonValue('rightArm') rightArm,
  @JsonValue('hip') hip,
  @JsonValue('leftKnee') leftKnee,
  @JsonValue('rightKnee') rightKnee,
  @JsonValue('leftAnkle') leftAnkle,
  @JsonValue('rightAnkle') rightAnkle,
}

List<String> _safeStringList(dynamic json) {
  if (json == null || json is! Iterable) return [];
  return json.map((e) => e.toString()).toList();
}

List<PainRegion> _safePainRegionList(dynamic json) {
  if (json == null || json is! Iterable) return [];
  return json.map((e) {
    if (e is PainRegion) return e;
    if (e is String) {
      return PainRegion.values.firstWhere(
        (val) => val.name == e,
        orElse: () => PainRegion.neck,
      );
    }
    return PainRegion.neck;
  }).toList();
}

/// Firestore-backed exercise model produced by the CDSS pipeline.
@freezed
abstract class ExerciseModel with _$ExerciseModel {
  const factory ExerciseModel({
    required String id,
    required String name,
    @Default([]) @JsonKey(fromJson: _safePainRegionList) List<PainRegion> targetRegions,
    required ExercisePhase phase,
    required String description,
    @Default([]) @JsonKey(fromJson: _safeStringList) List<String> steps,
    @Default([]) @JsonKey(fromJson: _safeStringList) List<String> warnings,
    @Default([]) @JsonKey(fromJson: _safeStringList) List<String> tips,
    @Default(2) int recommendedSets,
    @Default(10) int recommendedReps,
    String? videoUrl,
    String? imageUrl,
    @Default(true) bool isLocked,
    @Default(false) bool isJoker,
    int? estimatedDurationSeconds,
  }) = _ExerciseModel;

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);
}
