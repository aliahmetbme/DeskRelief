import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CalendarPage — High-fidelity Exercise Tracker (Real Logic + Selection)
// ─────────────────────────────────────────────────────────────────────────────
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  
  // Mock session data
  final Set<String> _sessionDays = {
    '2023-10-02', '2023-10-04', '2023-10-06',
    '2023-10-09', '2023-10-11', '2023-10-13',
    '2026-04-20', '2026-04-22', '2026-04-24',
  };

  void _nextMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1);
    });
  }

  void _prevMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1);
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Format for display
    final selectedLabel = '${_selectedDate.day} ${_CalendarSection._getMonthName(_selectedDate.month, true)}'.toUpperCase();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.top + 20)), 

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const _TitleSection(),
                const SizedBox(height: 32),

                _CalendarSection(
                  focusedDate: _focusedDate,
                  selectedDate: _selectedDate,
                  sessionDays: _sessionDays,
                  onPrev: _prevMonth,
                  onNext: _nextMonth,
                  onDateSelected: _onDateSelected,
                ),
                const SizedBox(height: 24),

                const _PhysioNoteCard(),
                const SizedBox(height: 32),

                _DayDetailSection(selectedLabel: selectedLabel),
                
                const SizedBox(height: 140),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_rounded, size: 14, color: theme.colorScheme.primary),
              const SizedBox(width: 6),
              Text(
                'KLİNİK PROGRAM',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Egzersiz Takvimi',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Fizyoterapi ilkelerine göre hazırlanan programınız sabittir. Maksimum verim için planlanan saatlere uyunuz.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _CalendarSection extends StatelessWidget {
  final DateTime focusedDate;
  final DateTime selectedDate;
  final Set<String> sessionDays;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final ValueChanged<DateTime> onDateSelected;

  const _CalendarSection({
    required this.focusedDate,
    required this.selectedDate,
    required this.sessionDays,
    required this.onPrev,
    required this.onNext,
    required this.onDateSelected,
  });

  static String _getMonthName(int month, [bool full = false]) {
    const names = [
      '', 'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
    ];
    return names[month];
  }

  List<List<DateTime>> _generateCalendarWeeks() {
    final firstOfMonth = DateTime(focusedDate.year, focusedDate.month, 1);
    final firstDayOffset = firstOfMonth.weekday - 1;
    final startDate = firstOfMonth.subtract(Duration(days: firstDayOffset));
    
    List<List<DateTime>> weeks = [];
    DateTime current = startDate;
    
    for (int i = 0; i < 5; i++) {
      List<DateTime> week = [];
      for (int j = 0; j < 7; j++) {
        week.add(current);
        current = current.add(const Duration(days: 1));
      }
      weeks.add(week);
    }
    return weeks;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weeks = _generateCalendarWeeks();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_getMonthName(focusedDate.month)} ${focusedDate.year}',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              children: [
                _CalendarNavButton(icon: Icons.chevron_left_rounded, onTap: onPrev),
                const SizedBox(width: 8),
                _CalendarNavButton(icon: Icons.chevron_right_rounded, onTap: onNext),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['PT', 'SA', 'ÇA', 'PE', 'CU', 'CT', 'PA']
                    .map((d) => Text(
                          d,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.55),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              ...weeks.map((week) => _CalendarRow(
                days: week.map((date) {
                  final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                  final isToday = date.day == DateTime.now().day && 
                                date.month == DateTime.now().month && 
                                date.year == DateTime.now().year;
                  final isSelected = date.day == selectedDate.day && 
                                   date.month == selectedDate.month && 
                                   date.year == selectedDate.year;
                  
                  return _CalDay(
                    date: date,
                    day: date.day.toString(),
                    isToday: isToday,
                    isSelected: isSelected,
                    hasSession: sessionDays.contains(dateKey),
                    isOld: date.month != focusedDate.month,
                    onTap: onDateSelected,
                  );
                }).toList(),
              )),
            ],
          ),
        ),
      ],
    );
  }
}

class _CalendarNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CalendarNavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          shape: BoxShape.circle,
          border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.05)),
        ),
        child: Center(child: Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant)),
      ),
    );
  }
}

class _CalendarRow extends StatelessWidget {
  final List<_CalDay> days;
  const _CalendarRow({required this.days});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days,
      ),
    );
  }
}

class _CalDay extends StatelessWidget {
  final DateTime date;
  final String day;
  final bool isToday;
  final bool isSelected;
  final bool hasSession;
  final bool isOld;
  final ValueChanged<DateTime> onTap;

  const _CalDay({
    required this.date,
    required this.day,
    this.isToday = false,
    this.isSelected = false,
    this.hasSession = false,
    this.isOld = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return GestureDetector(
      onTap: () => onTap(date),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isToday ? primary : (isSelected ? primary.withValues(alpha: 0.2) : (hasSession ? primary.withValues(alpha: 0.1) : Colors.transparent)),
          borderRadius: BorderRadius.circular(12),
          border: isSelected && !isToday 
              ? Border.all(color: primary, width: 1.5) 
              : null,
          boxShadow: isToday ? [BoxShadow(color: primary.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))] : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              day,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isToday || isSelected || hasSession ? FontWeight.w800 : FontWeight.w500,
                color: isToday
                    ? Colors.white
                    : (isSelected ? primary : (isOld ? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3) : (hasSession ? primary : theme.colorScheme.onSurface))),
              ),
            ),
            if (hasSession && !isToday)
              Positioned(
                bottom: 4,
                child: Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PhysioNoteCard extends StatelessWidget {
  const _PhysioNoteCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.health_and_safety_rounded, color: Colors.green, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fizyoterapist Notu',
                  style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF166534)),
                ),
                const SizedBox(height: 4),
                Text(
                  'Belirlenen saatlerdeki egzersizler omurga adaptasyonu için kritiktir. Mon-Wed-Fri döngüsü idealdir.',
                  style: TextStyle(
                    color: const Color(0xFF14532D).withValues(alpha: 0.7),
                    height: 1.4,
                    fontSize: 12,
                  ),
                ),
               ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DayDetailSection extends StatelessWidget {
  final String selectedLabel;
  const _DayDetailSection({required this.selectedLabel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gün Detayı',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                selectedLabel,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _TimeDetailBox(
                    label: 'BAŞLANGIÇ',
                    value: '19:00',
                    icon: Icons.schedule_rounded,
                    color: theme.colorScheme.primary,
                  ),
                  const Spacer(),
                  Container(width: 1, height: 40, color: theme.colorScheme.onSurface.withValues(alpha: 0.05)),
                  const Spacer(),
                  _TimeDetailBox(
                    label: 'TOPLAM SÜRE',
                    value: '25 dk',
                    icon: Icons.timer_rounded,
                    color: Colors.green,
                    isRight: true,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'ODAK BÖLGELERİ',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 12),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _FocusChip(label: 'Servikal Omurga', color: Colors.blue),
                  _FocusChip(label: 'Trapez Kasları', color: Color(0xFF10B981)),
                  _FocusChip(label: 'Skapular Stabilite', color: Colors.orange),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Program İçeriği',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    '6 HAREKET',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const _ExerciseItem(number: '01', title: 'Boyun İzometrik Güçlendirme', isCompleted: true),
              const SizedBox(height: 12),
              const _ExerciseItem(number: '02', title: 'Skapular Retraksiyon', isCompleted: false),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimeDetailBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool isRight;

  const _TimeDetailBox({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.isRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        if (!isRight)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.7)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
        if (!isRight) const SizedBox(width: 12),
        Column(
          crossAxisAlignment: isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                letterSpacing: 1.2,
              ),
            ),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        if (isRight) const SizedBox(width: 12),
        if (isRight)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
      ],
    );
  }
}

class _FocusChip extends StatelessWidget {
  final String label;
  final Color color;
  const _FocusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}

class _ExerciseItem extends StatelessWidget {
  final String number;
  final String title;
  final bool isCompleted;

  const _ExerciseItem({
    required this.number,
    required this.title,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCompleted ? Colors.transparent : theme.colorScheme.onSurface.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isCompleted ? Colors.white : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: isCompleted ? primary : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: isCompleted ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          if (isCompleted)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: primary.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(Icons.done_all_rounded, color: primary, size: 16),
            )
          else
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1), width: 2),
              ),
            ),
        ],
      ),
    );
  }
}
