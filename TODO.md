## [ ] GÖREV: UserModel'in Freezed ile Yeniden Yazılması
**Dosya Yolu:** `lib/features/auth/domain/models/user_model.dart`

**Adımlar:**
- [ ] Gerekli paketleri projeye ekle: `flutter pub add freezed_annotation json_annotation` ve `flutter pub add --dev build_runner freezed json_serializable`
- [ ] Sınıfı `@freezed` notasyonu ile oluştur ve şu alanları tanımla:
  * `String id`
  * `String name`
  * `String email`
  * `bool hasCompletedKineticEQ` (default: false)
  * `bool hasCompletedRedFlags` (default: false)
  * `bool isClearedForExercise` (default: false)
  * `int? dailySittingHours`
  * `List<String>? painRegions`
  * `int? nprsScore`
  * `int currentStreak` (default: 0)
  * `int totalWorkouts` (default: 0)
- [ ] `fromJson` ve `toJson` metotlarını (factory constructor) ekle.
- [ ] Terminalde `flutter pub run build_runner build --delete-conflicting-outputs` komutunu çalıştırarak `.freezed.dart` ve `.g.dart` dosyalarını üret.
