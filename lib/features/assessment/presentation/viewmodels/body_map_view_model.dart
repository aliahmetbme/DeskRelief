import 'package:flutter/foundation.dart';

class BodyMapViewModel extends ChangeNotifier {
  int _currentStep = 1;
  int get currentStep => _currentStep;

  final List<String> _selectedRegions = [];
  List<String> get selectedRegions => _selectedRegions;

  final List<String> _allRegions = [
    'region_neck',
    'region_shoulder_right',
    'region_shoulder_left',
    'region_lower_back',
    'region_hip_pelvis',
    'region_arm_right',
    'region_arm_left',
    'region_knee_right',
    'region_knee_left',
    'region_ankle_right',
    'region_ankle_left',
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

  void nextStep(List<String> selection) {
    if (kDebugMode) {
      print('Ağrı Şiddeti Belirleme Sayfasına Geçiliyor: $selection');
    }
  }
}
