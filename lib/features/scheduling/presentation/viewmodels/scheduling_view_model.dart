import 'package:flutter/material.dart';

/// Kullanıcının seçebileceği bildirim öncesi süre seçenekleri.
class NotificationOffset {
  final int minutes;
  final String label;
  const NotificationOffset({required this.minutes, required this.label});
}

class SchedulingViewModel extends ChangeNotifier {
  static const int maxDays = 3;

  /// Sabit preset listesi — kullanıcı bunlar dışında değer giremez.
  static const List<NotificationOffset> notificationOffsets = [
    NotificationOffset(minutes: 15, label: '15 dk önce'),
    NotificationOffset(minutes: 30, label: '30 dk önce'),
    NotificationOffset(minutes: 60, label: '1 saat önce'),
    NotificationOffset(minutes: 90, label: '1.5 saat önce'),
    NotificationOffset(minutes: 120, label: '2 saat önce'),
  ];

  /// Varsayılan offset: 60 dakika (1 saat önce)
  static const int _defaultOffsetMinutes = 60;

  final List<String> weekDays = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar',
  ];

  List<String> _selectedDays = [];
  Map<String, TimeOfDay> _workoutTimes = {};

  /// Bildirim için "antrenman saatinden kaç dakika önce" bilgisi.
  Map<String, int> _notificationOffsets = {};

  bool _isLoading = false;

  List<String> get selectedDays => List.unmodifiable(_selectedDays);
  bool get isLoading => _isLoading;
  bool get maxDaysReached => _selectedDays.length >= maxDays;

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

  /// Seçilen offset'in label'ını döner (örn. "1 saat önce").
  String notificationOffsetLabelForDay(String day) {
    final offset = notificationOffsetForDay(day);
    return notificationOffsets
        .firstWhere(
          (o) => o.minutes == offset,
          orElse: () => const NotificationOffset(
            minutes: _defaultOffsetMinutes,
            label: '1 saat önce',
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
        '(${notificationOffsetLabelForDay(day)})',
      );
    }

    _isLoading = false;
    notifyListeners();
  }
}
