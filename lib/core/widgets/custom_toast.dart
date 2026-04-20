import 'dart:ui';
import 'package:flutter/material.dart';

class CustomToast {
  static void show(BuildContext context, String message, {bool isError = true}) {
    final overlay = Overlay.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        isError: isError,
        isDark: isDark,
        onDismiss: () => entry.remove(),
      ),
    );

    overlay.insert(entry);
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final bool isError;
  final bool isDark;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.message,
    required this.isError,
    required this.isDark,
    required this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start above the screen
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut, // iOS-style bouncy entry
      ),
    );

    _controller.forward();

    // Auto dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _controller.animateTo(0, curve: Curves.easeIn).then((_) {
          if (mounted) {
            widget.onDismiss();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine status bar padding
    final topPadding = MediaQuery.of(context).padding.top;
    
    return Positioned(
      top: topPadding + 10,
      left: 16,
      right: 16,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: widget.isDark 
                        ? Colors.black.withOpacity(0.75) 
                        : Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: widget.isDark 
                          ? Colors.white.withOpacity(0.15) 
                          : Colors.black.withOpacity(0.08),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 25,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    bottom: false,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: (widget.isError ? const Color(0xFFFF453A) : const Color(0xFF32D74B)).withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            widget.isError ? Icons.error_outline : Icons.check_circle_outline,
                            color: widget.isError ? const Color(0xFFFF453A) : const Color(0xFF32D74B),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            widget.message,
                            style: TextStyle(
                              color: widget.isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
