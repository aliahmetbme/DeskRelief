import 'package:flutter/material.dart';
import '../../../exercise/domain/models/exercise_model.dart';

class BodyMapViewModel extends ChangeNotifier {
  int _currentStep = 2; // 2: Front, 1: Back
  int get currentStep => _currentStep;

  double _dragPosition = 0.0; // 0.0: Front (Left), 1.0: Back (Right)
  double get dragPosition => _dragPosition;
  bool _isDragging = false;
  bool get isDragging => _isDragging;

  // ─── ID-based selection store ──────────────────────────────────────────────
  // Keys are exact zone IDs from _zoneIdToClinicalRegion (e.g. 'shoulder_r_back').
  final List<String> _selectedZoneIds = [];

  /// Raw zone-ID list — used by the Flare-Up algorithm and clinical tracking.
  List<String> get rawSelectedZoneIds => _selectedZoneIds;

  /// Backward-compatible alias consumed by existing UI widgets that reference
  /// [selectedRegions] (e.g. body_map_page.dart chip list).
  List<String> get selectedRegions => _selectedZoneIds;

  // ─── All registered zone IDs ───────────────────────────────────────────────
  // Each entry must be a key in [_zoneIdToClinicalRegion].
  final List<String> _allRegions = [
    // Front view zones
    'neck_front',
    'shoulder_r_front',
    'shoulder_l_front',
    'hip_r_front',
    'hip_l_front',
    'arm_wrist_r_front',
    'arm_wrist_l_front',
    'knee_r_front',
    'knee_l_front',
    'ankle_r_front',
    'ankle_l_front',
    // Back view zones
    'neck_back',
    'shoulder_r_back',
    'shoulder_l_back',
    'upper_back',
    'lower_back',
    'hip_r_back',
    'hip_l_back',
    'arm_wrist_r_back',
    'arm_wrist_l_back',
    'knee_r_back',
    'knee_l_back',
    'ankle_r_back',
    'ankle_l_back',
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

  // ─── Coordinate Systems ────────────────────────────────────────────────────
  // Keys are exact zone IDs. Each zone has one or more Offset(x%, y%) points
  // positioned relative to the body image dimensions.

  Map<String, List<Offset>> backOffsetsMale = {
    'neck_back':         [const Offset(0.50, 0.12)],
    'shoulder_l_back':   [const Offset(0.41, 0.23)],
    'shoulder_r_back':   [const Offset(0.59, 0.23)],
    'upper_back':        [const Offset(0.50, 0.27)],
    'lower_back':        [const Offset(0.50, 0.36)],
    'hip_r_back':        [const Offset(0.58, 0.52)],
    'hip_l_back':        [const Offset(0.42, 0.52)],
    'arm_wrist_r_back':  [const Offset(0.68, 0.44)],
    'arm_wrist_l_back':  [const Offset(0.32, 0.44)],
    'knee_r_back':       [const Offset(0.56, 0.72)],
    'knee_l_back':       [const Offset(0.44, 0.72)],
    'ankle_r_back':      [const Offset(0.55, 0.93)],
    'ankle_l_back':      [const Offset(0.45, 0.93)],
  };

  Map<String, List<Offset>> frontOffsetsMale = {
    'neck_front':        [const Offset(0.50, 0.12)],
    'shoulder_r_front':  [const Offset(0.31, 0.23)],
    'shoulder_l_front':  [const Offset(0.69, 0.23)],
    'hip_r_front':       [const Offset(0.44, 0.52)],
    'hip_l_front':       [const Offset(0.56, 0.52)],
    'arm_wrist_r_front': [const Offset(0.31, 0.44)],
    'arm_wrist_l_front': [const Offset(0.69, 0.44)],
    'knee_r_front':      [const Offset(0.44, 0.72)],
    'knee_l_front':      [const Offset(0.56, 0.72)],
    'ankle_r_front':     [const Offset(0.45, 0.93)],
    'ankle_l_front':     [const Offset(0.55, 0.93)],
  };

  Map<String, List<Offset>> backOffsetsFemale = {
    'neck_back':         [const Offset(0.50, 0.13)],
    'shoulder_l_back':   [const Offset(0.42, 0.22)],
    'shoulder_r_back':   [const Offset(0.58, 0.22)],
    'upper_back':        [const Offset(0.50, 0.28)],
    'lower_back':        [const Offset(0.50, 0.37)],
    'hip_r_back':        [const Offset(0.58, 0.51)],
    'hip_l_back':        [const Offset(0.42, 0.51)],
    'arm_wrist_r_back':  [const Offset(0.67, 0.42)],
    'arm_wrist_l_back':  [const Offset(0.33, 0.42)],
    'knee_r_back':       [const Offset(0.56, 0.73)],
    'knee_l_back':       [const Offset(0.44, 0.73)],
    'ankle_r_back':      [const Offset(0.55, 0.93)],
    'ankle_l_back':      [const Offset(0.45, 0.93)],
  };

  Map<String, List<Offset>> frontOffsetsFemale = {
    'neck_front':        [const Offset(0.50, 0.13)],
    'shoulder_r_front':  [const Offset(0.32, 0.22)],
    'shoulder_l_front':  [const Offset(0.68, 0.22)],
    'hip_r_front':       [const Offset(0.44, 0.51)],
    'hip_l_front':       [const Offset(0.56, 0.51)],
    'arm_wrist_r_front': [const Offset(0.32, 0.42)],
    'arm_wrist_l_front': [const Offset(0.68, 0.42)],
    'knee_r_front':      [const Offset(0.44, 0.73)],
    'knee_l_front':      [const Offset(0.56, 0.73)],
    'ankle_r_front':     [const Offset(0.45, 0.93)],
    'ankle_l_front':     [const Offset(0.55, 0.93)],
  };

  void toggleRegion(String zoneId) {
    if (_selectedZoneIds.contains(zoneId)) {
      _selectedZoneIds.remove(zoneId);
    } else {
      _selectedZoneIds.add(zoneId);
    }
    notifyListeners();
  }

  void updateOffset(String zoneId, int index, Offset newOffset, bool isFemale) {
    final Map<String, List<Offset>> currentMap;
    if (_currentStep == 1) {
      currentMap = isFemale ? backOffsetsFemale : backOffsetsMale;
    } else {
      currentMap = isFemale ? frontOffsetsFemale : frontOffsetsMale;
    }

    if (currentMap.containsKey(zoneId) && currentMap[zoneId]!.length > index) {
      currentMap[zoneId]![index] = newOffset;
      notifyListeners();
      debugPrint(
        'DEBUG: $zoneId[$index] -> ${newOffset.dx.toStringAsFixed(3)}, ${newOffset.dy.toStringAsFixed(3)}',
      );
    }
  }

  void nextStep(List<String> selection) {
    debugPrint('Ağrı Şiddeti Belirleme Sayfasına Geçiliyor: $selection');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // CLINICAL MAPPING — ID Based Dictionary (O(1) Lookup)
  // ─────────────────────────────────────────────────────────────────────────

  static const Map<String, PainRegion> _zoneIdToClinicalRegion = {
    // BOYUN
    'neck_front': PainRegion.neck,
    'neck_back': PainRegion.neck,

    // OMUZ
    'shoulder_r_front': PainRegion.shoulder,
    'shoulder_l_front': PainRegion.shoulder,
    'shoulder_r_back': PainRegion.shoulder,
    'shoulder_l_back': PainRegion.shoulder,

    // SIRT VE BEL
    'upper_back': PainRegion.upperBack,
    'lower_back': PainRegion.lowerBack,

    // KALÇA / PELVİS
    'hip_r_front': PainRegion.hip,
    'hip_l_front': PainRegion.hip,
    'hip_r_back': PainRegion.hip,
    'hip_l_back': PainRegion.hip,

    // KOL VE BİLEK
    'arm_wrist_r_front': PainRegion.armWrist,
    'arm_wrist_l_front': PainRegion.armWrist,
    'arm_wrist_r_back': PainRegion.armWrist,
    'arm_wrist_l_back': PainRegion.armWrist,

    // DİZ
    'knee_r_front': PainRegion.knee,
    'knee_l_front': PainRegion.knee,
    'knee_r_back': PainRegion.knee,
    'knee_l_back': PainRegion.knee,

    // AYAK / BİLEK
    'ankle_r_front': PainRegion.ankle,
    'ankle_l_front': PainRegion.ankle,
    'ankle_r_back': PainRegion.ankle,
    'ankle_l_back': PainRegion.ankle,
  };

  /// O(1) lookup: maps an exact zone ID to its canonical [PainRegion].
  /// Falls back to [PainRegion.neck] for any unregistered ID.
  PainRegion mapUiIdToEnum(String zoneId) {
    return _zoneIdToClinicalRegion[zoneId] ?? PainRegion.neck;
  }

  /// Deduplicated clinical enum list — consumed by the Firestore exercise
  /// repository (arrayContainsAny query).
  List<PainRegion> get selectedClinicalRegions {
    final mapped = _selectedZoneIds.map(mapUiIdToEnum).toSet();
    return mapped.toList();
  }

  /// Backward-compatible alias used by the CDSS pipeline that still calls
  /// [selectedPainRegions] from the previous mapping iteration.
  List<PainRegion> get selectedPainRegions => selectedClinicalRegions;
}
