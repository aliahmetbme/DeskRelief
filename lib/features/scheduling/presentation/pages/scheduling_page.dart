import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../viewmodels/scheduling_view_model.dart';
import '../widgets/day_chip.dart';
import '../widgets/schedule_detail_card.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Scheduling Page
// ─────────────────────────────────────────────────────────────────────────────
class SchedulingPage extends StatelessWidget {
  const SchedulingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SchedulingViewModel>();
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? const Color(0xFFE8E9F0)
          : theme.scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      extendBody: true,

      // ─── Glassmorphism AppBar ──────────────────────────────────────────────
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(68),
        child: Container(
          color: Colors.transparent,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Row(
                children: [
                  AppBackButton(onTap: () => context.pop()),
                  const SizedBox(width: 14),
                  Text(
                    'Program Planlaması',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.onSurface,
                      letterSpacing: -0.5,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ─── Body ─────────────────────────────────────────────────────────────
      body: Stack(
        children: [
          // Scrollable içerik
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              20,
              topPadding + 68, // AppBar hemen altından başla
              20,
              bottomPadding + 90,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Klinik Tavsiye Kartı
                _ClinicalAdviceCard(theme: theme),
                const SizedBox(height: 24),

                // 2. Gün Seçimi
                _DaySelectionSection(viewModel: viewModel, theme: theme),
                const SizedBox(height: 24),

                // 3. Zamanlama Detayları
                if (viewModel.selectedDays.isNotEmpty) ...[
                  _ScheduleDetailsSection(viewModel: viewModel, theme: theme),
                  const SizedBox(height: 24),
                ],

                // 4. Hero Görsel
                _HeroImage(theme: theme),
              ],
            ),
          ),

          // ─── Şeffaf Floating Footer ──────────────────────────────────────
          Positioned(
            left: 20,
            right: 20,
            bottom: bottomPadding + 6,
            child: _StartButton(viewModel: viewModel, theme: theme),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Floating "Programımı Başlat" Butonu
// ─────────────────────────────────────────────────────────────────────────────
class _StartButton extends StatelessWidget {
  final SchedulingViewModel viewModel;
  final ThemeData theme;
  const _StartButton({required this.viewModel, required this.theme});

  @override
  Widget build(BuildContext context) {
    final primary = theme.colorScheme.primary;
    return GestureDetector(
      onTap: viewModel.isLoading ? null : () => viewModel.completeScheduling(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              primary,
              HSLColor.fromColor(primary)
                  .withLightness(
                    (HSLColor.fromColor(primary).lightness + 0.08).clamp(
                      0.0,
                      1.0,
                    ),
                  )
                  .toColor(),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.38),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: viewModel.isLoading
              ? const CupertinoActivityIndicator(color: Colors.white)
              : Text(
                  'Programımı Başlat',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. Klinik Tavsiye Kartı
// ─────────────────────────────────────────────────────────────────────────────
class _ClinicalAdviceCard extends StatelessWidget {
  final ThemeData theme;
  const _ClinicalAdviceCard({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.10),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: theme.colorScheme.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Klinik Tavsiye',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Kas liflerinizin kendini onarması ve postür gelişiminin '
                  'kalıcı olması için antrenmanlar arasında en az 24 saat '
                  'dinlenme bırakılması önerilir.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.6,
                    fontSize: 12.5,
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

// ─────────────────────────────────────────────────────────────────────────────
// 2. Gün Seçimi Bölümü
// ─────────────────────────────────────────────────────────────────────────────
class _DaySelectionSection extends StatelessWidget {
  final SchedulingViewModel viewModel;
  final ThemeData theme;
  const _DaySelectionSection({required this.viewModel, required this.theme});

  @override
  Widget build(BuildContext context) {
    final selectedCount = viewModel.selectedDays.length;
    final maxDays = SchedulingViewModel.maxDays;
    final limitReached = viewModel.maxDaysReached;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Başlık satırı
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gün Seçimi',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
                letterSpacing: -0.4,
                fontSize: 18,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: limitReached
                    ? theme.colorScheme.primary.withValues(alpha: 0.12)
                    : theme.colorScheme.onSurface.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                '$selectedCount / $maxDays',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  color: limitReached
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Chip listesi
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: viewModel.weekDays.map((day) {
            final isSelected = viewModel.isDaySelected(day);
            final isDisabled = !isSelected && limitReached;
            return DayChip(
              day: day,
              isSelected: isSelected,
              isDisabled: isDisabled,
              onTap: () {
                final ok = viewModel.toggleDay(day);
                if (!ok) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'En fazla 3 gün seçebilirsiniz.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 12),

        // Öneri notu
        Row(
          children: [
            Icon(
              Icons.lightbulb_outline_rounded,
              size: 14,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                'En fazla 3 gün · Gün aşırı antrenman önerilir.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Zamanlama Detayları  (StatefulWidget — Cupertino picker için)
// ─────────────────────────────────────────────────────────────────────────────
class _ScheduleDetailsSection extends StatefulWidget {
  final SchedulingViewModel viewModel;
  final ThemeData theme;
  const _ScheduleDetailsSection({required this.viewModel, required this.theme});

  @override
  State<_ScheduleDetailsSection> createState() =>
      _ScheduleDetailsSectionState();
}

class _ScheduleDetailsSectionState extends State<_ScheduleDetailsSection> {
  // ── iOS Cupertino Saat Seçici ─────────────────────────────────────────────
  void _showCupertinoTimePicker(
    BuildContext context,
    String day,
    TimeOfDay currentTime,
  ) {
    final now = DateTime.now();
    var pickerTime = DateTime(
      now.year,
      now.month,
      now.day,
      currentTime.hour,
      currentTime.minute,
    );

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        final theme = widget.theme;
        final isDark = theme.brightness == Brightness.dark;
        final sheetBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
        final dividerColor = isDark
            ? const Color(0xFF38383A)
            : const Color(0xFFC6C6C8);
        final handleColor = isDark
            ? const Color(0xFF48484A)
            : const Color(0xFFD1D1D6);

        return Container(
          decoration: BoxDecoration(
            color: sheetBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 2),
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: handleColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Başlık + İptal / Tamam
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(
                        'İptal',
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark
                              ? CupertinoColors.systemGrey
                              : CupertinoColors.systemGrey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Antrenman Saati',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(
                        'Bitti',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, thickness: 0.5, color: dividerColor),
              // Picker
              SizedBox(
                height: 220,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  initialDateTime: pickerTime,
                  backgroundColor: Colors.transparent,
                  onDateTimeChanged: (DateTime dt) {
                    pickerTime = dt;
                    widget.viewModel.updateTime(
                      day,
                      TimeOfDay.fromDateTime(dt),
                    );
                  },
                ),
              ),
              // Home indicator boşluğu
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final theme = widget.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Zamanlama Detayları',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.onSurface,
            letterSpacing: -0.4,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 14),
        ...viewModel.selectedDays.map((day) {
          final workoutTime = viewModel.timeForDay(day);
          final notifLabel = viewModel.notificationOffsetLabelForDay(day);
          final currentOffset = viewModel.notificationOffsetForDay(day);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ScheduleDetailCard(
              day: day,
              workoutTime: workoutTime,
              notificationLabel: notifLabel,
              onWorkoutTimeTap: () =>
                  _showCupertinoTimePicker(context, day, workoutTime),
              onNotificationTap: () async {
                final picked = await showNotificationOffsetPicker(
                  context,
                  currentOffsetMinutes: currentOffset,
                );
                if (picked != null) {
                  viewModel.updateNotificationOffset(day, picked);
                }
              },
            ),
          );
        }),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Hero Görsel
// ─────────────────────────────────────────────────────────────────────────────
class _HeroImage extends StatelessWidget {
  final ThemeData theme;
  const _HeroImage({required this.theme});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 180,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=800&q=80',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                child: Icon(
                  Icons.fitness_center_rounded,
                  color: theme.colorScheme.primary.withValues(alpha: 0.25),
                  size: 52,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.55),
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
            const Positioned(
              bottom: 18,
              left: 20,
              child: Text(
                'Hazır olduğunda başlayalım.',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: -0.2,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
