import 'package:flutter/foundation.dart';

class BodyMapViewModel extends ChangeNotifier {
  int _currentStep = 1;
  int get currentStep => _currentStep;

  final List<String> _selectedRegions = [];
  List<String> get selectedRegions => _selectedRegions;

  final List<String> _allRegions = [
    'Boyun', 'Sağ Omuz', 'Sol Omuz', 'Bel', 'Kalça',
    'Sağ El/Dirsek/Bilek', 'Sol El/Dirsek/Bilek',
    'Sağ Diz', 'Sol Diz',
    'Sağ Ayak Bileği', 'Sol Ayak Bileği'
  ];
  List<String> get allRegions => _allRegions;

  void toggleRegion(String region) {
    if (_selectedRegions.contains(region)) {
      _selectedRegions.remove(region);
    } else {
      _selectedRegions.add(region);
    }
    notifyListeners();
  }

  void toggleStep() {
    _currentStep = _currentStep == 1 ? 2 : 1;
    notifyListeners();
  }

  void nextStep() {
    // Tüm bölgeler tek bir aşamada seçildiği için direkt tamamlıyoruz
    if (kDebugMode) {
      print('Seçilen Bölgeler: $_selectedRegions');
    }
    // İleride buraya sayfalar arası geçiş eklenecek.
  }
}
