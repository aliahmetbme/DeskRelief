// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegistrationProgress _$RegistrationProgressFromJson(
  Map<String, dynamic> json,
) => _RegistrationProgress(
  hasCompletedWelcome: json['hasCompletedWelcome'] as bool? ?? false,
  hasCompletedRedFlags: json['hasCompletedRedFlags'] as bool? ?? false,
  hasCompletedBodyMap: json['hasCompletedBodyMap'] as bool? ?? false,
  hasCompletedPainScore: json['hasCompletedPainScore'] as bool? ?? false,
  hasCompletedScheduling: json['hasCompletedScheduling'] as bool? ?? false,
  isClearedForExercise: json['isClearedForExercise'] as bool? ?? false,
);

Map<String, dynamic> _$RegistrationProgressToJson(
  _RegistrationProgress instance,
) => <String, dynamic>{
  'hasCompletedWelcome': instance.hasCompletedWelcome,
  'hasCompletedRedFlags': instance.hasCompletedRedFlags,
  'hasCompletedBodyMap': instance.hasCompletedBodyMap,
  'hasCompletedPainScore': instance.hasCompletedPainScore,
  'hasCompletedScheduling': instance.hasCompletedScheduling,
  'isClearedForExercise': instance.isClearedForExercise,
};

_RegionDetail _$RegionDetailFromJson(Map<String, dynamic> json) =>
    _RegionDetail(
      regionId: json['regionId'] as String,
      nprsScore: (json['nprsScore'] as num?)?.toInt() ?? 0,
      flareUpCount: (json['flareUpCount'] as num?)?.toInt() ?? 0,
      lastFlareUpDate: const TimestampConverter().fromJson(
        json['lastFlareUpDate'],
      ),
      isAkut: json['isAkut'] as bool? ?? false,
      scoreHistory:
          (json['scoreHistory'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RegionDetailToJson(_RegionDetail instance) =>
    <String, dynamic>{
      'regionId': instance.regionId,
      'nprsScore': instance.nprsScore,
      'flareUpCount': instance.flareUpCount,
      'lastFlareUpDate': const TimestampConverter().toJson(
        instance.lastFlareUpDate,
      ),
      'isAkut': instance.isAkut,
      'scoreHistory': instance.scoreHistory,
    };

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  gender: json['gender'] as String?,
  job: json['job'] as String?,
  height: (json['height'] as num?)?.toDouble(),
  weight: (json['weight'] as num?)?.toDouble(),
  isSedentary: json['isSedentary'] as bool? ?? true,
  dailySittingHours: (json['dailySittingHours'] as num?)?.toInt(),
  isBanned: json['isBanned'] as bool? ?? false,
  banReason: $enumDecodeNullable(
    _$BanReasonEnumMap,
    json['banReason'],
    unknownValue: BanReason.chronicLimit,
  ),
  banNote: json['banNote'] as String?,
  flaggedRedFlagIds: json['flaggedRedFlagIds'] == null
      ? const []
      : _safeStringList(json['flaggedRedFlagIds']),
  progress: json['progress'] == null
      ? const RegistrationProgress()
      : RegistrationProgress.fromJson(json['progress'] as Map<String, dynamic>),
  painRegions:
      (json['painRegions'] as List<dynamic>?)
          ?.map((e) => RegionDetail.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  backlogRegions:
      (json['backlogRegions'] as List<dynamic>?)
          ?.map((e) => RegionDetail.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  completedExerciseIds: json['completedExerciseIds'] == null
      ? const []
      : _safeStringList(json['completedExerciseIds']),
  currentProgram: json['currentProgram'] as Map<String, dynamic>?,
  currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
  totalWorkouts: (json['totalWorkouts'] as num?)?.toInt() ?? 0,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  lastActiveAt: const TimestampConverter().fromJson(json['lastActiveAt']),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'job': instance.job,
      'height': instance.height,
      'weight': instance.weight,
      'isSedentary': instance.isSedentary,
      'dailySittingHours': instance.dailySittingHours,
      'isBanned': instance.isBanned,
      'banReason': _$BanReasonEnumMap[instance.banReason],
      'banNote': instance.banNote,
      'flaggedRedFlagIds': instance.flaggedRedFlagIds,
      'progress': instance.progress.toJson(),
      'painRegions': instance.painRegions.map((e) => e.toJson()).toList(),
      'backlogRegions': instance.backlogRegions.map((e) => e.toJson()).toList(),
      'completedExerciseIds': instance.completedExerciseIds,
      'currentProgram': instance.currentProgram,
      'currentStreak': instance.currentStreak,
      'totalWorkouts': instance.totalWorkouts,
      'metadata': instance.metadata,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'lastActiveAt': const TimestampConverter().toJson(instance.lastActiveAt),
    };

const _$BanReasonEnumMap = {
  BanReason.redFlag: 'redFlag',
  BanReason.centralSensitization: 'centralSensitization',
  BanReason.extremePain: 'extremePain',
  BanReason.maxFlareUpStrike: 'maxFlareUpStrike',
  BanReason.persistentFlareUp: 'persistentFlareUp',
  BanReason.therapeuticResistance: 'therapeuticResistance',
  BanReason.chronicLimit: 'chronicLimit',
};
