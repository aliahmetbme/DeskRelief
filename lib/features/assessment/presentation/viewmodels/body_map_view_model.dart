import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../exercise/domain/models/exercise_model.dart';
import '../../../auth/domain/models/user_model.dart';
import '../../../auth/presentation/viewmodels/auth_view_model.dart';

class BodyMapViewModel extends ChangeNotifier {
  int _currentStep = 2; // 2: Front, 1: Back
  int get currentStep => _currentStep;

  double _dragPosition = 0.0; // 0.0: Front (Left), 1.0: Back (Right)
  double get dragPosition => _dragPosition;
  bool _isDragging = false;
  bool get isDragging => _isDragging;
  
  String? _currentUid;
  bool _isFemale = false;
  bool get isFemale => _isFemale;

  void updateUser(UserModel? user) {
    if (user != null) {
      _isFemale = user.gender == 'female';
      if (_currentUid != user.id) {
        _currentUid = user.id;
        // Reset or reload state if needed when user changes
        notifyListeners();
      }
    } else {
      _currentUid = null;
      _isFemale = false;
      _selectedZoneIds.clear();
      _dragPosition = 0.0;
      _currentStep = 2;
      notifyListeners();
    }
  }

  final List<String> _selectedZoneIds = [];
  List<String> get rawSelectedZoneIds => _selectedZoneIds;
  List<String> get selectedRegions => _selectedZoneIds;

  List<String> get frontRegions {
    final regions = _allRegions.where((id) => id.endsWith('_front')).toList();
    if (_isFemale) {
      // Kadın bedeninde ön tarafta boyun, omuz ve kalçaları gizle
      regions.remove('neck_front');
      regions.remove('shoulder_r_front');
      regions.remove('shoulder_l_front');
      regions.remove('hip_r_front');
      regions.remove('hip_l_front');
    }
    return regions;
  }
  List<String> get backRegions => _allRegions.where((id) => id.endsWith('_back')).toList();

  String getRegionLocalizationKey(String id) {
    switch (id) {
      case 'neck_front':
      case 'neck_back':
        return 'regionNeck';
      case 'shoulder_r_front':
      case 'shoulder_r_back':
        return 'rightShoulder';
      case 'shoulder_l_front':
      case 'shoulder_l_back':
        return 'leftShoulder';
      case 'hip_r_front':
      case 'hip_r_back':
      case 'hip_l_front':
      case 'hip_l_back':
        return 'regionHipPelvis';
      case 'upper_back':
        return 'regionUpperBack';
      case 'lower_back':
        return 'regionLowerBack';
      case 'arm_wrist_r_front':
      case 'arm_wrist_r_back':
        return 'rightArm';
      case 'arm_wrist_l_front':
      case 'arm_wrist_l_back':
        return 'leftArm';
      case 'knee_r_front':
      case 'knee_r_back':
        return 'rightKnee';
      case 'knee_l_front':
      case 'knee_l_back':
        return 'leftKnee';
      case 'ankle_r_front':
      case 'ankle_r_back':
        return 'rightAnkle';
      case 'ankle_l_front':
      case 'ankle_l_back':
        return 'leftAnkle';
      default:
        return id;
    }
  }

  Future<void> submitSelection(BuildContext context, AuthViewModel authVM) async {
    if (_selectedZoneIds.isEmpty) return;

    final clinicalRegions = selectedClinicalRegions.map((e) => e.name).toList();
    
    // AuthViewModel üzerinden ilerlemeyi güncelle
    await authVM.updateProgress(hasCompletedBodyMap: true);
    
    if (context.mounted) {
      // Bir sonraki adıma yönlendir
      GoRouter.of(context).push('/assessment/pain-intensity', extra: clinicalRegions);
    }
  }

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
    }
  }

  void nextStep(List<String> selection) {}

  static const Map<String, PainRegion> _zoneIdToClinicalRegion = {
    // BOYUN
    'neck_front': PainRegion.neck,
    'neck_back': PainRegion.neck,

    // OMUZ
    'shoulder_r_front': PainRegion.rightShoulder,
    'shoulder_l_front': PainRegion.leftShoulder,
    'shoulder_r_back': PainRegion.rightShoulder,
    'shoulder_l_back': PainRegion.leftShoulder,

    // SIRT VE BEL
    'upper_back': PainRegion.upperBack,
    'lower_back': PainRegion.lowerBack,

    // KALÇA / PELVİS
    'hip_r_front': PainRegion.hip,
    'hip_l_front': PainRegion.hip,
    'hip_r_back': PainRegion.hip,
    'hip_l_back': PainRegion.hip,

    // KOL VE BİLEK
    'arm_wrist_r_front': PainRegion.rightArm,
    'arm_wrist_l_front': PainRegion.leftArm,
    'arm_wrist_r_back': PainRegion.rightArm,
    'arm_wrist_l_back': PainRegion.leftArm,

    // DİZ
    'knee_r_front': PainRegion.rightKnee,
    'knee_l_front': PainRegion.leftKnee,
    'knee_r_back': PainRegion.rightKnee,
    'knee_l_back': PainRegion.leftKnee,

    // AYAK / BİLEK
    'ankle_r_front': PainRegion.rightAnkle,
    'ankle_l_front': PainRegion.leftAnkle,
    'ankle_r_back': PainRegion.rightAnkle,
    'ankle_l_back': PainRegion.leftAnkle,
  };

  PainRegion mapUiIdToEnum(String zoneId) {
    return _zoneIdToClinicalRegion[zoneId] ?? PainRegion.neck;
  }

  List<PainRegion> get selectedClinicalRegions {
    final mapped = _selectedZoneIds.map(mapUiIdToEnum).toSet();
    return mapped.toList();
  }

  List<PainRegion> get selectedPainRegions => selectedClinicalRegions;
}
