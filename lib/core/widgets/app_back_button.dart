import 'package:flutter/material.dart';

/// Uygulamanın standart geri butonu.
/// Koyu yuvarlak arka plan üzerinde primary renkli chevron ikonu.
class AppBackButton extends StatefulWidget {
  final VoidCallback? onTap;

  const AppBackButton({super.key, this.onTap});

  @override
  State<AppBackButton> createState() => _AppBackButtonState();
}

class _AppBackButtonState extends State<AppBackButton> {
  bool _isProcessing = false;

  void _handleTap() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);
    
    if (widget.onTap != null) {
      widget.onTap!();
    } else {
      Navigator.of(context).maybePop();
    }
    
    // Sayfa geçişi tamamlanana kadar (veya kısa bir süre) butonu kilitli tutuyoruz
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) setState(() => _isProcessing = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: _handleTap,
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
