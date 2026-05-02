import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Klinik Güvenlik Blokaj Nedenleri
enum BanReason {
  @JsonValue('redFlag')
  redFlag,
  @JsonValue('centralSensitization')
  centralSensitization,
  @JsonValue('extremePain')
  extremePain,
  @JsonValue('maxFlareUpStrike')
  maxFlareUpStrike,
  @JsonValue('persistentFlareUp')
  persistentFlareUp,
  @JsonValue('therapeuticResistance')
  therapeuticResistance,
  @JsonValue('chronicLimit')
  chronicLimit
}

class TimestampConverter implements JsonConverter<DateTime?, dynamic> {
  const TimestampConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.tryParse(json);
    return null;
  }

  @override
  dynamic toJson(DateTime? date) => date;
}

@freezed
abstract class RegistrationProgress with _$RegistrationProgress {
  const factory RegistrationProgress({
    @Default(false) bool hasCompletedWelcome,
    @Default(false) bool hasCompletedRedFlags,
    @Default(false) bool hasCompletedBodyMap,
    @Default(false) bool hasCompletedPainScore,
    @Default(false) bool hasCompletedScheduling,
    @Default(false) bool isClearedForExercise,
  }) = _RegistrationProgress;

  factory RegistrationProgress.fromJson(Map<String, dynamic> json) => _$RegistrationProgressFromJson(json);
}

@freezed
abstract class RegionDetail with _$RegionDetail {
  const factory RegionDetail({
    required String regionId,
    @Default(0) int nprsScore,
    @Default(0) int flareUpCount,
    @TimestampConverter() DateTime? lastFlareUpDate,
    @Default(false) bool isAkut,
    @Default([]) List<int> scoreHistory,
  }) = _RegionDetail;

  factory RegionDetail.fromJson(Map<String, dynamic> json) => _$RegionDetailFromJson(json);
}

List<String> _safeStringList(dynamic json) {
  if (json == null || json is! Iterable) return [];
  return json.map((e) => e.toString()).toList();
}

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required String email,
    String? gender,
    String? job,
    double? height,
    double? weight,
    @Default(true) bool isSedentary,
    int? dailySittingHours,
    @Default(false) bool isBanned,
    @JsonKey(unknownEnumValue: BanReason.chronicLimit) BanReason? banReason,
    String? banNote,
    @Default([]) @JsonKey(fromJson: _safeStringList) List<String> flaggedRedFlagIds,
    @Default(RegistrationProgress()) RegistrationProgress progress,
    @Default([]) List<RegionDetail> painRegions,
    @Default([]) List<RegionDetail> backlogRegions,
    @Default([]) @JsonKey(fromJson: _safeStringList) List<String> completedExerciseIds,
    Map<String, dynamic>? currentProgram,
    @Default(0) int currentStreak,
    @Default(0) int totalWorkouts,
    Map<String, dynamic>? metadata, 
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? lastActiveAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
