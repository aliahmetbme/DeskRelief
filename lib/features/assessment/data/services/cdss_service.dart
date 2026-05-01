import '../../../auth/domain/models/user_model.dart';

/// CDSS (Klinik Karar Destek Sistemi) Servisi
/// Primum Non Nocere (Önce Zarar Verme) ilkesine göre kullanıcı güvenliğini denetler.
class CDSSService {
  
  /// Kullanıcının verilerini analiz eder ve eğer bir blokaj gerekliyse [BanReason] döner.
  /// Hiçbir risk yoksa null döner.
  static BanReason? checkForClinicalBlock(UserModel user) {
    
    // 1. Red Flag Kontrolü (Genelde UI katmanında set edilir ama burada da kontrol edelim)
    // hasCompletedRedFlags true olduğu halde isClearedForExercise false ise manuel blokaj olabilir.
    if (user.progress.hasCompletedRedFlags && !user.progress.isClearedForExercise) {
      return BanReason.redFlag;
    }

    // 2. Extreme Pain Kontrolü (NPRS skoru 10 olan bölge var mı?)
    final hasExtremePain = user.painRegions.any((r) => r.nprsScore >= 10);
    if (hasExtremePain) return BanReason.extremePain;

    // 3. Central Sensitization Kontrolü
    // Kural: Seçilen 4 bölgeden (veya daha fazlası) 3'ünün skoru 8 veya üzeriyse.
    if (user.painRegions.length >= 4) {
      final highPainRegions = user.painRegions.where((r) => r.nprsScore >= 8).length;
      if (highPainRegions >= 3) return BanReason.centralSensitization;
    }

    // 4. Max Flare-Up Strike (Aynı bölgede 3. kriz)
    final hasMaxFlareUps = user.painRegions.any((r) => r.flareUpCount >= 3);
    if (hasMaxFlareUps) return BanReason.maxFlareUpStrike;

    // 5. Therapeutic Resistance (Tedaviye Direnç)
    // 28. veya 56. gün makro değerlendirmede skorun düşmek yerine artması durumu.
    // Bu kontrol için scoreHistory'nin son 2 değerine bakılabilir (Makro değerlendirme anında).
    for (var region in user.painRegions) {
      if (region.scoreHistory.length >= 2) {
        final lastScore = region.scoreHistory.last;
        final previousScore = region.scoreHistory[region.scoreHistory.length - 2];
        
        // Eğer skor bir önceki makro değerlendirmeden daha yüksekse (İyileşme yok, kötüleşme var)
        if (lastScore > previousScore) {
          return BanReason.therapeuticResistance;
        }
      }
    }

    // 6. Persistent Flare-Up & Chronic Limit
    // Bu maddeler zamana dayalı (14, 28, 56 gün) kontroller olduğu için 
    // seans takip mantığı eklendiğinde daha detaylı işlenecektir.

    return null; // Her şey yolunda
  }
}
