import 'package:flutter/foundation.dart';

class PainIntensityViewModel extends ChangeNotifier {
  final List<String> _selectedRegions;
  int _currentIndex = 0;
  final Map<String, double> _painValues = {};

  PainIntensityViewModel({required List<String> selectedRegions})
      : _selectedRegions = selectedRegions {
    // Tüm bölgeleri varsayılan olarak orta şiddete (5.0) ayarla
    for (var region in _selectedRegions) {
      _painValues[region] = 5.0;
    }
  }

  List<String> get selectedRegions => _selectedRegions;
  int get currentIndex => _currentIndex;
  String get currentRegion => _selectedRegions.isNotEmpty ? _selectedRegions[_currentIndex] : '';
  double get currentPainValue => _painValues[currentRegion] ?? 5.0;
  int get totalRegions => _selectedRegions.length;

  void setPainValue(double value) {
    _painValues[currentRegion] = value;
    notifyListeners();
  }

  bool get isLastRegion => _currentIndex == _selectedRegions.length - 1;

  /// Ağrı skoruna göre azalan sırayla ilk 2 bölge (odak bölgeler).
  List<String> get topPainRegions {
    final sorted = _painValues.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(2).map((e) => e.key).toList();
  }

  void nextRegion(void Function(List<String> focusRegions) onFinished) {
    if (isLastRegion) {
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

  String get painLevelDescription {
    final val = currentPainValue.round();
    if (val <= 2) return 'Hafif';
    if (val <= 4) return 'Hafif-Orta';
    if (val <= 6) return 'Orta Şiddetli';
    if (val <= 8) return 'Şiddetli';
    return 'Çok Şiddetli';
  }

  String get painLevelAnalysis {
    final val = currentPainValue.round();
    if (val <= 2) {
      return 'Seviye $val, günlük hayatı pek etkilemeyen hafif bir ağrıdır. Hareketlilikle düzelebilir.';
    } else if (val <= 4) {
      return 'Seviye $val, hissedilen ancak katlanılabilir bir ağrıdır. Esneme hareketleri faydalı olacaktır.';
    } else if (val <= 6) {
      return 'Seviye $val, dikkat edilmesi gereken orta şiddetli bir ağrıdır. Kuvvet ve esneklik dengesi hedeflenecektir.';
    } else if (val <= 8) {
      return 'Seviye $val, aktiviteleri kısıtlayan şiddetli bir ağrıdır. Kontrollü ve nazik egzersizler gereklidir.';
    } else {
      return 'Seviye $val, çok şiddetli bir ağrıdır. Uzman kontrolünde ilerlemek ve dinlenmek önemlidir.';
    }
  }
}
