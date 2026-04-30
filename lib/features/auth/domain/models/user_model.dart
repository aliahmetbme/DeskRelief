import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Klinik Güvenlik Blokaj Nedenleri
enum BanReason { 
  @JsonValue('redFlag') redFlag,
  @JsonValue('extremePain') extremePain,
  @JsonValue('persistentFlareUp') persistentFlareUp,
  @JsonValue('medicalReview') medicalReview 
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

/// Kayıt Süreci Takibi (Senin istediğin 4 durak + Klinik onay)
@freezed
abstract class RegistrationProgress with _$RegistrationProgress {
  @JsonSerializable(explicitToJson: true)
  const factory RegistrationProgress({
    @Default(false) bool hasCompletedWelcome,     // 1. Tik: İsim, meslek vb.
    @Default(false) bool hasCompletedRedFlags,    // 1.5 Tik: Tıbbi tarama
    @Default(false) bool hasCompletedBodyMap,     // 2. Tik: Bölge seçimi
    @Default(false) bool hasCompletedPainScore,   // 3. Tik: NPRS girişleri
    @Default(false) bool hasCompletedScheduling,  // 4. Tik: Takvim kurulumu
    @Default(false) bool isClearedForExercise,    // CDSS Güvenlik Filtresi
  }) = _RegistrationProgress;

  factory RegistrationProgress.fromJson(Map<String, dynamic> json) => _$RegistrationProgressFromJson(json);
}

/// Bölge Bazlı Klinik Detay (ID bazlı)
@freezed
abstract class RegionDetail with _$RegionDetail {
  @JsonSerializable(explicitToJson: true)
  const factory RegionDetail({
    required String regionId,       // "neck", "lower_back" vb.
    @Default(0) int nprsScore,
    @Default(0) int flareUpCount,
    @TimestampConverter() DateTime? lastFlareUpDate,
    @Default(false) bool isAkut,
    @Default([]) List<int> scoreHistory,
  }) = _RegionDetail;

  factory RegionDetail.fromJson(Map<String, dynamic> json) => _$RegionDetailFromJson(json);
}

/// DeskRelief Ana Kullanıcı Modeli
@freezed
abstract class UserModel with _$UserModel {
  @JsonSerializable(explicitToJson: true)
  const factory UserModel({
    required String id,             // Firebase UID
    required String name,
    required String email,
    String? sex,
    String? profession,
    int? dailySittingHours,

    // Ban Durumu
    @Default(false) bool isBanned,
    BanReason? banReason,
    String? banNote,

    // Progresyon ve Bölgeler
    @Default(RegistrationProgress()) RegistrationProgress progress,
    @Default([]) List<RegionDetail> painRegions,
    @Default([]) List<RegionDetail> backlogRegions,
    
    // İstatistikler
    @Default([]) List<String> completedExerciseIds,
    Map<String, dynamic>? currentProgram,
    @Default(0) int currentStreak,
    @Default(0) int totalWorkouts,
    
    Map<String, dynamic>? metadata, 
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? lastActiveAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
