import 'package:flutter/material.dart';

/// Uygulamanın standart geri butonu.
/// Koyu yuvarlak arka plan üzerinde primary renkli chevron ikonu.
class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AppBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).maybePop(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isDark
              ? theme.colorScheme.primary.withValues(alpha: 0.15)
              : theme.colorScheme.onSurface.withValues(alpha: 0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
