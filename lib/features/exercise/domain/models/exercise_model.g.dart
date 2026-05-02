// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseModel _$ExerciseModelFromJson(
  Map<String, dynamic> json,
) => _ExerciseModel(
  id: json['id'] as String,
  name: json['name'] as String,
  targetRegions: (json['targetRegions'] as List<dynamic>)
      .map((e) => $enumDecode(_$PainRegionEnumMap, e))
      .toList(),
  phase: $enumDecode(_$ExercisePhaseEnumMap, json['phase']),
  description: json['description'] as String,
  steps:
      (json['steps'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  warnings:
      (json['warnings'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  tips:
      (json['tips'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  recommendedSets: (json['recommendedSets'] as num?)?.toInt() ?? 2,
  recommendedReps: (json['recommendedReps'] as num?)?.toInt() ?? 10,
  videoUrl: json['videoUrl'] as String?,
  imageUrl: json['imageUrl'] as String?,
  isLocked: json['isLocked'] as bool? ?? true,
  isJoker: json['isJoker'] as bool? ?? false,
  estimatedDurationSeconds: (json['estimatedDurationSeconds'] as num?)?.toInt(),
);

Map<String, dynamic> _$ExerciseModelToJson(_ExerciseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'targetRegions': instance.targetRegions
          .map((e) => _$PainRegionEnumMap[e]!)
          .toList(),
      'phase': _$ExercisePhaseEnumMap[instance.phase]!,
      'description': instance.description,
      'steps': instance.steps,
      'warnings': instance.warnings,
      'tips': instance.tips,
      'recommendedSets': instance.recommendedSets,
      'recommendedReps': instance.recommendedReps,
      'videoUrl': instance.videoUrl,
      'imageUrl': instance.imageUrl,
      'isLocked': instance.isLocked,
      'isJoker': instance.isJoker,
      'estimatedDurationSeconds': instance.estimatedDurationSeconds,
    };

const _$PainRegionEnumMap = {
  PainRegion.neck: 'neck',
  PainRegion.leftShoulder: 'leftShoulder',
  PainRegion.rightShoulder: 'rightShoulder',
  PainRegion.upperBack: 'upperBack',
  PainRegion.lowerBack: 'lowerBack',
  PainRegion.leftArm: 'leftArm',
  PainRegion.rightArm: 'rightArm',
  PainRegion.hip: 'hip',
  PainRegion.leftKnee: 'leftKnee',
  PainRegion.rightKnee: 'rightKnee',
  PainRegion.leftAnkle: 'leftAnkle',
  PainRegion.rightAnkle: 'rightAnkle',
};

const _$ExercisePhaseEnumMap = {
  ExercisePhase.rom: 'rom',
  ExercisePhase.strength: 'strength',
  ExercisePhase.stretch: 'stretch',
};
