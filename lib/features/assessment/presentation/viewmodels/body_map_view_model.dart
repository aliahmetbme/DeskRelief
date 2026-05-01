import 'package:flutter/material.dart';

class BodyMapViewModel extends ChangeNotifier {
  int _currentStep = 2; // 2: Front, 1: Back
  int get currentStep => _currentStep;

  double _dragPosition = 0.0; // 0.0: Front (Left), 1.0: Back (Right)
  double get dragPosition => _dragPosition;
  bool _isDragging = false;
  bool get isDragging => _isDragging;

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

  void toggleStep() {
    _currentStep = _currentStep == 1 ? 2 : 1;
    _dragPosition = _currentStep == 2 ? 0.0 : 1.0;
    notifyListeners();
  }

  void updateDragPosition(double val) {
    _isDragging = true;
    _dragPosition = val.clamp(0.0, 1.0);
    notifyListeners();
  }

  void finalizeDrag() {
    _isDragging = false;
    if (_dragPosition > 0.5) {
      _currentStep = 1; // Back
      _dragPosition = 1.0;
    } else {
      _currentStep = 2; // Front
      _dragPosition = 0.0;
    }
    notifyListeners();
  }

  // Koordinat Sistemleri
  Map<String, List<Offset>> backOffsetsMale = {
    'region_neck': [const Offset(0.50, 0.12)],
    'region_shoulder_left': [const Offset(0.41, 0.23)],
    'region_shoulder_right': [const Offset(0.59, 0.23)],
    'region_lower_back': [const Offset(0.50, 0.36)],
    'region_hip_pelvis': [const Offset(0.42, 0.52), const Offset(0.58, 0.52)],
    'region_arm_right': [const Offset(0.68, 0.44)],
    'region_arm_left': [const Offset(0.32, 0.44)],
    'region_knee_right': [const Offset(0.56, 0.72)],
    'region_knee_left': [const Offset(0.44, 0.72)],
    'region_ankle_right': [const Offset(0.55, 0.93)],
    'region_ankle_left': [const Offset(0.45, 0.93)],
  };

  Map<String, List<Offset>> frontOffsetsMale = {
    'region_arm_right': [const Offset(0.31, 0.44)],
    'region_arm_left': [const Offset(0.69, 0.44)],
    'region_knee_right': [const Offset(0.44, 0.72)],
    'region_knee_left': [const Offset(0.56, 0.72)],
    'region_ankle_right': [const Offset(0.45, 0.93)],
    'region_ankle_left': [const Offset(0.55, 0.93)],
  };

  Map<String, List<Offset>> backOffsetsFemale = {
    'region_neck': [const Offset(0.50, 0.13)],
    'region_shoulder_left': [const Offset(0.42, 0.22)],
    'region_shoulder_right': [const Offset(0.58, 0.22)],
    'region_lower_back': [const Offset(0.50, 0.37)],
    'region_hip_pelvis': [const Offset(0.42, 0.51), const Offset(0.58, 0.51)],
    'region_arm_right': [const Offset(0.67, 0.42)],
    'region_arm_left': [const Offset(0.33, 0.42)],
    'region_knee_right': [const Offset(0.56, 0.73)],
    'region_knee_left': [const Offset(0.44, 0.73)],
    'region_ankle_right': [const Offset(0.55, 0.93)],
    'region_ankle_left': [const Offset(0.45, 0.93)],
  };

  Map<String, List<Offset>> frontOffsetsFemale = {
    'region_arm_right': [const Offset(0.32, 0.42)],
    'region_arm_left': [const Offset(0.68, 0.42)],
    'region_knee_right': [const Offset(0.44, 0.73)],
    'region_knee_left': [const Offset(0.56, 0.73)],
    'region_ankle_right': [const Offset(0.45, 0.93)],
    'region_ankle_left': [const Offset(0.55, 0.93)],
  };

  void toggleRegion(String region) {
    if (_selectedRegions.contains(region)) {
      _selectedRegions.remove(region);
    } else {
      _selectedRegions.add(region);
    }
    notifyListeners();
  }

  void updateOffset(String region, int index, Offset newOffset, bool isFemale) {
    Map<String, List<Offset>> currentMap;
    if (_currentStep == 1) {
      currentMap = isFemale ? backOffsetsFemale : backOffsetsMale;
    } else {
      currentMap = isFemale ? frontOffsetsFemale : frontOffsetsMale;
    }

    if (currentMap.containsKey(region) && currentMap[region]!.length > index) {
      currentMap[region]![index] = newOffset;
      notifyListeners();
      debugPrint('DEBUG: $region[$index] -> ${newOffset.dx.toStringAsFixed(3)}, ${newOffset.dy.toStringAsFixed(3)}');
    }
  }

  void nextStep(List<String> selection) {
    debugPrint('Ağrı Şiddeti Belirleme Sayfasına Geçiliyor: $selection');
  }
}
