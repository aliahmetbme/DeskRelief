import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../exercise/domain/models/exercise_model.dart';
import '../../../auth/presentation/viewmodels/auth_view_model.dart';
import '../../../auth/domain/models/user_model.dart';
import '../../../../core/theme/app_colors.dart';

/// Ağrı bölgelerinin özelliklerini ve klinik önceliklerini temsil eden sınıf.
class PainRegionInfo {
  final String id;
  final int
  priority; // 1: Yüksek (Örn: Boyun, Bel), 2: Düşük (Örn: Omuz, Dirsek)

  const PainRegionInfo({required this.id, required this.priority});
}

/// Klinik Öncelik Grupları ve Sabit ID Tanımlamaları.
/// Bu yapı PainRegion enum'ı ile %100 uyumlu hale getirilmiştir.
class PainRegions {
  // Öncelik 1: Masa Başı Odaklı - Yüksek Öncelik
  static final String neck = PainRegion.neck.name;
  static final String lowerBack = PainRegion.lowerBack.name;
  static final String upperBack = PainRegion.upperBack.name;
  static final String hip = PainRegion.hip.name;

  // Öncelik 2: İkincil - Düşük Öncelik (Lateralize Bölgeler)
  static final String leftShoulder = PainRegion.leftShoulder.name;
  static final String rightShoulder = PainRegion.rightShoulder.name;
  static final String leftArm = PainRegion.leftArm.name;
  static final String rightArm = PainRegion.rightArm.name;
  static final String leftKnee = PainRegion.leftKnee.name;
  static final String rightKnee = PainRegion.rightKnee.name;
  static final String leftAnkle = PainRegion.leftAnkle.name;
  static final String rightAnkle = PainRegion.rightAnkle.name;

  /// Tüm bölgelerin öncelik haritası.
  static Map<String, PainRegionInfo> get all => {
    neck: PainRegionInfo(id: neck, priority: 1),
    lowerBack: PainRegionInfo(id: lowerBack, priority: 1),
    upperBack: PainRegionInfo(id: upperBack, priority: 1),
    hip: PainRegionInfo(id: hip, priority: 1),
    leftShoulder: PainRegionInfo(id: leftShoulder, priority: 2),
    rightShoulder: PainRegionInfo(id: rightShoulder, priority: 2),
    leftArm: PainRegionInfo(id: leftArm, priority: 2),
    rightArm: PainRegionInfo(id: rightArm, priority: 2),
    leftKnee: PainRegionInfo(id: leftKnee, priority: 2),
    rightKnee: PainRegionInfo(id: rightKnee, priority: 2),
    leftAnkle: PainRegionInfo(id: leftAnkle, priority: 2),
    rightAnkle: PainRegionInfo(id: rightAnkle, priority: 2),
  };
}

class PainIntensityViewModel extends ChangeNotifier {
  final List<String> _selectedRegions;
  int _currentIndex = 0;
  final Map<String, double> _painValues = {};

  PainIntensityViewModel({List<String>? selectedRegions})
      : _selectedRegions = selectedRegions ?? [] {
    for (var regionId in _selectedRegions) {
      _painValues[regionId] = 5.0;
    }
  }

  void setRegions(List<String> regions) {
    if (regions.isNotEmpty) {
      _selectedRegions.clear();
      _selectedRegions.addAll(regions);
      for (var regionId in _selectedRegions) {
        if (!_painValues.containsKey(regionId)) {
          _painValues[regionId] = 5.0;
        }
      }
      notifyListeners();
    }
  }

  String? _currentUid;

  void updateUser(UserModel? user) {
    if (user != null) {
      if (_currentUid != user.id) {
        _currentUid = user.id;
        
        // Eğer seçili bölge yoksa ama user'da varsa otomatik doldur
        if (_selectedRegions.isEmpty && user.painRegions.isNotEmpty) {
          _selectedRegions.clear();
          _selectedRegions.addAll(user.painRegions.map((e) => e.regionId));
          for (var regionId in _selectedRegions) {
            _painValues[regionId] = 5.0;
          }
        }
        notifyListeners();
      }
    } else {
      _currentUid = null;
      _selectedRegions.clear();
      _painValues.clear();
      _currentIndex = 0;
      notifyListeners();
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

  int _getPriority(String regionId) {
    return PainRegions.all[regionId]?.priority ?? 2;
  }

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

  List<String> get topPainRegions {
    if (_painValues.isEmpty) return [];
    final sortedEntries = _painValues.entries.toList()
      ..sort((a, b) {
        int scoreCmp = b.value.compareTo(a.value);
        if (scoreCmp != 0) return scoreCmp;
        final priorityA = _getPriority(a.key);
        final priorityB = _getPriority(b.key);
        return priorityA.compareTo(priorityB);
      });

    if (sortedEntries.length < 2) {
      return sortedEntries.map((e) => e.key).toList();
    }
    final top1 = sortedEntries[0];
    final top2 = sortedEntries[1];
    if (top1.value - top2.value >= 4.0) {
      return [top1.key];
    }
    return sortedEntries.take(2).map((e) => e.key).toList();
  }

  void nextRegion(void Function(List<String> focusRegions) onFinished) {
    if (isLastRegion) {
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

  void finishAssessment() {}

  String getPainLevelDescriptionKey() {
    final val = currentPainValue.round();
    if (val <= 2) return 'painLevelLight';
    if (val <= 4) return 'painLevelMild';
    if (val <= 6) return 'painLevelModerate';
    if (val <= 8) return 'painLevelSevere';
    return 'painLevelVerySevere';
  }

  String getPainLevelAnalysisKey() {
    final val = currentPainValue.round();
    if (val <= 2) return 'painAnalysisLight';
    if (val <= 4) return 'painAnalysisMild';
    if (val <= 6) return 'painAnalysisModerate';
    if (val <= 8) return 'painAnalysisSevere';
    return 'painAnalysisVerySevere';
  }

  Color getPainColor(BuildContext context, double val) {
    final theme = Theme.of(context);
    final drColors = theme.extension<DeskReliefColors>()!;
    
    if (val <= 3) return drColors.success ?? Colors.green;
    if (val <= 6) return drColors.warning ?? Colors.orange;
    return drColors.error ?? theme.colorScheme.error;
  }

  String getRegionLocalizationKey(String id) {
    switch (id) {
      case 'neck': return 'regionNeck';
      case 'leftShoulder': return 'leftShoulder';
      case 'rightShoulder': return 'rightShoulder';
      case 'upperBack': return 'regionUpperBack';
      case 'lowerBack': return 'regionLowerBack';
      case 'hip': return 'regionHipPelvis';
      case 'leftArm': return 'leftArm';
      case 'rightArm': return 'rightArm';
      case 'leftKnee': return 'leftKnee';
      case 'rightKnee': return 'rightKnee';
      case 'leftAnkle': return 'leftAnkle';
      case 'rightAnkle': return 'rightAnkle';
      default: return id;
    }
  }

  Future<void> submitPainScores(BuildContext context, AuthViewModel authVM, List<String> focusRegions) async {
    await authVM.updateProgress(hasCompletedPainScore: true);
    if (context.mounted) {
      context.push('/scheduling', extra: focusRegions);
    }
  }

  Future<void> submitMedicalBlock(BuildContext context, AuthViewModel authVM) async {
    await authVM.updateProgress(isClearedForExercise: false);
    if (context.mounted) {
      context.go('/');
    }
  }
}
