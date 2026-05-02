import 'package:flutter/material.dart';
import 'package:deskrelief/features/auth/domain/models/user_model.dart';

/// Kullanıcının seçebileceği bildirim öncesi süre seçenekleri.
class NotificationOffset {
  final int minutes;
  final String label;
  const NotificationOffset({required this.minutes, required this.label});
}

class SchedulingViewModel extends ChangeNotifier {
  List<String> _focusRegions = [];
  List<String> get focusRegions => _focusRegions;

  SchedulingViewModel({List<String>? initialRegions}) : _focusRegions = initialRegions ?? [];

  void setFocusRegions(List<String> regions) {
    _focusRegions = regions;
    notifyListeners();
  }

  void updateUser(UserModel? user) {
    if (user != null) {
      if (_focusRegions.isEmpty && user.painRegions.isNotEmpty) {
        _focusRegions = user.painRegions.map((e) => e.regionId).toList();
        notifyListeners();
      }
    } else {
      _focusRegions = [];
      _selectedDays.clear();
      _workoutTimes.clear();
      _notificationOffsets.clear();
      notifyListeners();
    }
  }

  /// Sabit preset listesi — kullanıcı bunlar dışında değer giremez.
  static const List<NotificationOffset> notificationOffsets = [
    NotificationOffset(minutes: 15, label: 'offset_15m'),
    NotificationOffset(minutes: 30, label: 'offset_30m'),
    NotificationOffset(minutes: 60, label: 'offset_1h'),
    NotificationOffset(minutes: 90, label: 'offset_1_5h'),
    NotificationOffset(minutes: 120, label: 'offset_2h'),
  ];

  /// Varsayılan offset: 60 dakika (1 saat önce)
  static const int _defaultOffsetMinutes = 60;

  final List<String> weekDays = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  final List<String> _selectedDays = [];
  final Map<String, TimeOfDay> _workoutTimes = {};

  /// Bildirim için "antrenman saatinden kaç dakika önce" bilgisi.
  final Map<String, int> _notificationOffsets = {};

  bool _isLoading = false;

  List<String> get selectedDays => List.unmodifiable(_selectedDays);
  bool get isLoading => _isLoading;

  /// Uzman Sistem Kuralı: Bölge sayısına göre maksimum gün limiti
  int get maxDays => focusRegions.length == 1 ? 3 : 4;

  bool get maxDaysReached => _selectedDays.length >= maxDays;

  /// Uzman Sistem Kuralı: Kullanıcının devam edebilmesi için gerekli şartlar:
  /// 1 Bölge varsa -> 2 veya 3 gün seçilmeli
  /// 2 Bölge varsa -> tam 4 gün seçilmeli
  bool get canProceed {
    if (focusRegions.isEmpty) return false;
    
    if (focusRegions.length == 1) {
      return _selectedDays.length >= 2 && _selectedDays.length <= 3;
    } else {
      // 2 veya daha fazla bölge için her zaman 4 gün kuralı
      return _selectedDays.length == 4;
    }
  }

  /// UI'da gösterilecek dinamik klinik talimat metni anahtarı
  String get instructionKey {
    if (focusRegions.isEmpty) return 'schedulingInstructionEmpty';
    if (focusRegions.length == 1) return 'schedulingInstructionSingle';
    return 'schedulingInstructionMulti';
  }

  TimeOfDay timeForDay(String day) =>
      _workoutTimes[day] ?? const TimeOfDay(hour: 19, minute: 0);

  int notificationOffsetForDay(String day) =>
      _notificationOffsets[day] ?? _defaultOffsetMinutes;

  /// Antrenman saatinden [offset] dk önce hesaplanmış bildirim saatini döner.
  TimeOfDay notificationTimeForDay(String day) {
    final workout = timeForDay(day);
    final totalMins = workout.hour * 60 + workout.minute;
    final notifMins = (totalMins - notificationOffsetForDay(day)).clamp(
      0,
      1439,
    );
    return TimeOfDay(hour: notifMins ~/ 60, minute: notifMins % 60);
  }

  /// Seçilen offset'in label anahtarını döner.
  String notificationOffsetKeyForDay(String day) {
    final offset = notificationOffsetForDay(day);
    return notificationOffsets
        .firstWhere(
          (o) => o.minutes == offset,
          orElse: () => const NotificationOffset(
            minutes: _defaultOffsetMinutes,
            label: 'offset_1h',
          ),
        )
        .label;
  }

  bool isDaySelected(String day) => _selectedDays.contains(day);

  /// Gün seçimini aç/kapa. Max [maxDays] gün seçilebilir.
  /// Seçiliyse kaldırılır ve [true] döner.
  /// Limit doluysa [false] döner.
  bool toggleDay(String day) {
    if (_selectedDays.contains(day)) {
      _selectedDays.remove(day);
      _workoutTimes.remove(day);
      _notificationOffsets.remove(day);
      notifyListeners();
      return true;
    }
    if (maxDaysReached) return false;

    _selectedDays.add(day);
    _workoutTimes[day] = const TimeOfDay(hour: 19, minute: 0);
    _notificationOffsets[day] = _defaultOffsetMinutes;
    notifyListeners();
    return true;
  }

  void updateTime(String day, TimeOfDay newTime) {
    if (!_selectedDays.contains(day)) return;
    _workoutTimes[day] = newTime;
    // Antrenman saati değişince offset korunur — hesaplanan bildirim saati
    // otomatik güncellenir (offset-tabanlı olduğundan geçersizlik riski yok).
    notifyListeners();
  }

  /// Bildirim offset'ini güncelle. Sadece [notificationOffsets] listesindeki
  /// değerlere izin verilir — geçersiz değer girmek mümkün değildir.
  void updateNotificationOffset(String day, int offsetMinutes) {
    if (!_selectedDays.contains(day)) return;
    assert(
      notificationOffsets.any((o) => o.minutes == offsetMinutes),
      'Yalnızca önceden tanımlı offset değerleri kullanılabilir.',
    );
    _notificationOffsets[day] = offsetMinutes;
    notifyListeners();
  }

  Future<void> completeScheduling() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    for (final day in _selectedDays) {
      final workout = timeForDay(day);
      final notif = notificationTimeForDay(day);
      debugPrint(
        'Gün: $day — '
        'Antrenman: ${workout.hour.toString().padLeft(2, '0')}:${workout.minute.toString().padLeft(2, '0')} — '
        'Bildirim: ${notif.hour.toString().padLeft(2, '0')}:${notif.minute.toString().padLeft(2, '0')} '
        '(${notificationOffsetKeyForDay(day)})',
      );
    }

    _isLoading = false;
    notifyListeners();
  }
}
