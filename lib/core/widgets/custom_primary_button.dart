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

    // Yüksekliği h-14 (56px) ve tam yuvarlak köşeler
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28), // rounded-full (h/2)
        color: theme.colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
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
                ? CupertinoActivityIndicator(color: theme.colorScheme.onPrimary)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.text,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (widget.icon != null) ...[
                        const SizedBox(width: 8),
                        Icon(widget.icon, color: theme.colorScheme.onPrimary, size: 22),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
