import 'package:flutter/foundation.dart';
import 'package:deskrelief/l10n/app_localizations.dart';

/// Ağrı bölgelerinin özelliklerini ve klinik önceliklerini temsil eden sınıf.
class PainRegionInfo {
  final String id;
  final int
  priority; // 1: Yüksek (Örn: Boyun, Bel), 2: Düşük (Örn: Omuz, Dirsek)

  const PainRegionInfo({required this.id, required this.priority});
}

/// Klinik Öncelik Grupları ve Sabit ID Tanımlamaları.
/// Bu yapı çoklu dil (localization) desteği için anahtar (key) görevi görür.
class PainRegions {
  // Öncelik 1: Masa Başı Odaklı - Yüksek Öncelik
  static const String neck = 'region_neck';
  static const String lowerBack = 'region_lower_back';
  static const String hipPelvis = 'region_hip_pelvis';
  static const String kneeRight = 'region_knee_right';
  static const String kneeLeft = 'region_knee_left';

  // Öncelik 2: İkincil - Düşük Öncelik
  static const String shoulderRight = 'region_shoulder_right';
  static const String shoulderLeft = 'region_shoulder_left';
  static const String armRight = 'region_arm_right';
  static const String armLeft = 'region_arm_left';
  static const String ankleRight = 'region_ankle_right';
  static const String ankleLeft = 'region_ankle_left';

  /// Tüm bölgelerin öncelik haritası.
  static const Map<String, PainRegionInfo> all = {
    neck: PainRegionInfo(id: neck, priority: 1),
    lowerBack: PainRegionInfo(id: lowerBack, priority: 1),
    hipPelvis: PainRegionInfo(id: hipPelvis, priority: 1),
    kneeRight: PainRegionInfo(id: kneeRight, priority: 1),
    kneeLeft: PainRegionInfo(id: kneeLeft, priority: 1),
    shoulderRight: PainRegionInfo(id: shoulderRight, priority: 2),
    shoulderLeft: PainRegionInfo(id: shoulderLeft, priority: 2),
    armRight: PainRegionInfo(id: armRight, priority: 2),
    armLeft: PainRegionInfo(id: armLeft, priority: 2),
    ankleRight: PainRegionInfo(id: ankleRight, priority: 2),
    ankleLeft: PainRegionInfo(id: ankleLeft, priority: 2),
  };
}

class PainIntensityViewModel extends ChangeNotifier {
  final List<String>
  _selectedRegions; // Artık ID'leri (örn: region_neck) tutar.
  int _currentIndex = 0;
  final Map<String, double> _painValues = {};

  PainIntensityViewModel({required List<String> selectedRegions})
    : _selectedRegions = selectedRegions {
    // Tüm bölgeleri varsayılan olarak orta şiddete (5.0) ayarlar.
    for (var regionId in _selectedRegions) {
      _painValues[regionId] = 5.0;
    }
  }

  List<String> get selectedRegions => _selectedRegions;
  int get currentIndex => _currentIndex;
  String get currentRegion =>
      _selectedRegions.isNotEmpty ? _selectedRegions[_currentIndex] : '';
  double get currentPainValue => _painValues[currentRegion] ?? 5.0;
  int get totalRegions => _selectedRegions.length;

  void setPainValue(double value) {
    if (currentRegion.isNotEmpty) {
      _painValues[currentRegion] = value;
      notifyListeners();
    }
  }

  bool get isLastRegion => _currentIndex == _selectedRegions.length - 1;

  /// Bölgesel Öncelik (Tie-Breaker) Kuralı için yardımcı metod.
  /// 1. Grup (Masa Başı Kritik) her zaman Öncelik 1'dir.
  /// 2. Grup (İkincil) Öncelik 2'dir.
  int _getPriority(String region) {
    const priority1Regions = [
      'region_neck',
      'region_lower_back',
      'region_hip_pelvis',
      'region_knee_right',
      'region_knee_left',
    ];
    return priority1Regions.contains(region) ? 1 : 2;
  }

  /// YENİ EKLENTİ: Kırmızı Bayrak (Red Flag) Kontrolü
  /// Literatürdeki "Merkezi Duyarlılaşma / Fibromiyalji" senaryosunu yakalar.
  bool get hasRedFlag {
    if (_selectedRegions.length < 4) return false;

    int severePainCount = 0;
    for (var region in _selectedRegions) {
      if ((_painValues[region] ?? 0.0) >= 8.0) {
        severePainCount++;
      }
    }
    return severePainCount >= 3;
  }

  /// UZMAN SİSTEM ALGORİTMASI (topPainRegions):
  /// Kullanıcının seçtiği bölgeler arasından en kritik olanları 3 klinik kurala göre seçer.
  List<String> get topPainRegions {
    if (_painValues.isEmpty) return [];

    // KURAL 1: Sıralama ve Beraberlik
    // Bölgeleri ağrı puanına (NPRS) göre büyükten küçüğe sıralar.
    // Eğer puanlar eşitse, "Öncelik 1" olan bölgeyi, "Öncelik 2" olan bölgenin üstüne çıkarır.
    final sortedEntries = _painValues.entries.toList()
      ..sort((a, b) {
        // Önce ağrı puanı (NPRS) karşılaştırması (Büyükten küçüğe)
        int scoreCmp = b.value.compareTo(a.value);
        if (scoreCmp != 0) return scoreCmp;

        // Puanlar eşitse klinik öncelik (Priority) karşılaştırması (1: Yüksek, 2: Düşük)
        final priorityA = _getPriority(a.key);
        final priorityB = _getPriority(b.key);
        return priorityA.compareTo(priorityB);
      });

    if (sortedEntries.length < 2) {
      return sortedEntries.map((e) => e.key).toList();
    }

    final top1 = sortedEntries[0];
    final top2 = sortedEntries[1];

    // KURAL 2: İzolasyon / Kırmızı Çizgi
    // Sıralama yapıldıktan sonra, birinci sıradaki ağrı ile ikinci sıradaki ağrı arasında
    // 4 veya daha fazla puan farkı varsa; ikinciyi ve sonrakileri yok say, sadece birinciyi al.
    if (top1.value - top2.value >= 4.0) {
      return [top1.key];
    }

    // KURAL 3: Top 2 Limitasyonu
    // Kural 2 tetiklenmediyse (fark 4'ten küçükse), sadece en yüksek puanlı ilk 2 bölgeyi dön.
    return sortedEntries.take(2).map((e) => e.key).toList();
  }

  void nextRegion(void Function(List<String> focusRegions) onFinished) {
    if (isLastRegion) {
      // Egzersiz reçetesi oluşturulmadan hemen önce verileri kaydet
      finishAssessment();
      onFinished(topPainRegions);
    } else {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousRegion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  /// Değerlendirme sürecini tamamlar ve verileri kalıcı hale getirir.
  void finishAssessment() {
    // TODO: Seçilen TÜM bölgeleri (sadece top 2 değil, kullanıcının girdiği tüm bölgeleri ve ağrı skorlarını) Firebase/Firestore veritabanına kullanıcının geçmiş veri analizi (historical tracking) için kaydet.
  }

  // --- UI Yardımcı Metodları (Analiz metinleri ideal olarak localization'a taşınmalıdır) ---

  String getPainLevelDescription(AppLocalizations loc) {
    final val = currentPainValue.round();
    if (val <= 2) return loc.painLevelLight;
    if (val <= 4) return loc.painLevelMild;
    if (val <= 6) return loc.painLevelModerate;
    if (val <= 8) return loc.painLevelSevere;
    return loc.painLevelVerySevere;
  }

  String getPainLevelAnalysis(AppLocalizations loc) {
    final val = currentPainValue.round();
    if (val <= 2) {
      return loc.painAnalysisLight(val);
    } else if (val <= 4) {
      return loc.painAnalysisMild(val);
    } else if (val <= 6) {
      return loc.painAnalysisModerate(val);
    } else if (val <= 8) {
      return loc.painAnalysisSevere(val);
    } else {
      return loc.painAnalysisVerySevere(val);
    }
  }
}
