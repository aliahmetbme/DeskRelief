import 'package:flutter/material.dart';

class DayChip extends StatelessWidget {
  final String day;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback onTap;

  const DayChip({
    super.key,
    required this.day,
    required this.isSelected,
    this.isDisabled = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Opacity(
      opacity: isDisabled ? 0.38 : 1.0,
      child: IgnorePointer(
        ignoring: isDisabled,
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? primary
                  : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: isSelected
                    ? primary
                    : theme.dividerColor.withValues(alpha: 0.35),
                width: 1.2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: primary.withValues(alpha: 0.32),
                        blurRadius: 16,
                        spreadRadius: 0,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: theme.shadowColor.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ],
            ),
            child: Text(
              day,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.1,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
