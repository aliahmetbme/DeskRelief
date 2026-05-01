import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    theme.scaffoldBackgroundColor,
                    const Color(0xFF001A4D).withValues(alpha: 0.1),
                    theme.scaffoldBackgroundColor,
                  ]
                : [
                    theme.scaffoldBackgroundColor,
                    const Color(0xFFE6F0FF),
                    theme.scaffoldBackgroundColor,
                  ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Alanı (Veya uygulama ikonu)
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(alpha: 0.15),
                          blurRadius: 40,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.accessibility_new_rounded,
                      size: 64,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            // Uygulama Adı
            Text(
              'DeskRelief',
              style: GoogleFonts.manrope(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.0,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            // Slogan
            Text(
              'Smart Spinal Wellness',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 60),
            // Premium Loading Indicator
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
