import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final IconData? icon;

  const CustomPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  State<CustomPrimaryButton> createState() => _CustomPrimaryButtonState();
}

class _CustomPrimaryButtonState extends State<CustomPrimaryButton> {
  bool _isNavigating = false;

  void _handlePress() async {
    if (widget.onPressed == null || widget.isLoading || _isNavigating) return;

    setState(() => _isNavigating = true);
    widget.onPressed!();

    // Sayfa geçişi için yeterli süre butonu kilitliyoruz
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) setState(() => _isNavigating = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    // Yüksekliği h-14 (56px) ve tam yuvarlak köşeler
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28), // rounded-full (h/2)
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1D4ED8), // blue-700
            Color(0xFF3B82F6), // blue-500
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: (widget.isLoading || _isNavigating) ? null : _handlePress,
          child: Center(
            child: (widget.isLoading || _isNavigating)
                ? const CupertinoActivityIndicator(color: Colors.white)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.text,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (widget.icon != null) ...[
                        const SizedBox(width: 8),
                        Icon(widget.icon, color: Colors.white, size: 22),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
