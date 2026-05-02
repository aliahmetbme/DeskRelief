import 'package:flutter/material.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import '../viewmodels/scheduling_view_model.dart';

class ScheduleDetailCard extends StatelessWidget {
  final String day;
  final TimeOfDay workoutTime;
  final String notificationLabel; // örn. "1 saat önce"
  final VoidCallback onWorkoutTimeTap;
  final VoidCallback onNotificationTap;

  const ScheduleDetailCard({
    super.key,
    required this.day,
    required this.workoutTime,
    required this.notificationLabel,
    required this.onWorkoutTimeTap,
    required this.onNotificationTap,
  });

  String _formatTime(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // ── Antrenman Saati ──────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: -0.2,
                ),
              ),
              _TimeChip(
                label: _formatTime(workoutTime),
                color: theme.colorScheme.primary,
                onTap: onWorkoutTimeTap,
                theme: theme,
              ),
            ],
          ),

          const SizedBox(height: 14),
          Divider(
            height: 1,
            thickness: 1,
            color: theme.dividerColor.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 14),

          // ── Bildirim Offset ──────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications_active_rounded,
                    size: 15,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    AppLocalizations.of(context)!.notification,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              _TimeChip(
                label: notificationLabel,
                color: theme.colorScheme.primary,
                onTap: onNotificationTap,
                theme: theme,
                backgroundAlpha: 0.07,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Küçük dokunulabilir etiket chip'i
// ─────────────────────────────────────────────────────────────────────────────
class _TimeChip extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final ThemeData theme;
  final double backgroundAlpha;

  const _TimeChip({
    required this.label,
    required this.color,
    required this.onTap,
    required this.theme,
    this.backgroundAlpha = 0.10,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: color.withValues(alpha: backgroundAlpha),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.20), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 14,
              color: color.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bildirim offset seçici bottom sheet
// ─────────────────────────────────────────────────────────────────────────────
Future<int?> showNotificationOffsetPicker(
  BuildContext context, {
  required int currentOffsetMinutes,
}) {
  final theme = Theme.of(context);

  return showModalBottomSheet<int>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) {
      return Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.notificationTimeTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              AppLocalizations.of(context)!.notificationTimeDesc,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            ...SchedulingViewModel.notificationOffsets.map((option) {
              final isSelected = option.minutes == currentOffsetMinutes;
              return _OffsetTile(
                option: option,
                isSelected: isSelected,
                theme: theme,
                onTap: () => Navigator.of(context).pop(option.minutes),
              );
            }),
          ],
        ),
      );
    },
  );
}

class _OffsetTile extends StatelessWidget {
  final NotificationOffset option;
  final bool isSelected;
  final ThemeData theme;
  final VoidCallback onTap;

  const _OffsetTile({
    required this.option,
    required this.isSelected,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.10)
              : theme.colorScheme.onSurface.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary.withValues(alpha: 0.30)
                : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _getTranslatedOffset(context, option.label),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                size: 20,
                color: theme.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }

  String _getTranslatedOffset(BuildContext context, String key) {
    final loc = AppLocalizations.of(context)!;
    switch (key) {
      case 'offset_15m': return loc.offset_15m;
      case 'offset_30m': return loc.offset_30m;
      case 'offset_1h': return loc.offset_1h;
      case 'offset_1_5h': return loc.offset_1_5h;
      case 'offset_2h': return loc.offset_2h;
      default: return key;
    }
  }
}
