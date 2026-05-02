import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_palettes.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData buildTheme(BuildContext context, AppPalette palette, {bool isDark = false}) {
    final Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    
    // Modern Slate-based background colors for better depth in Dark Mode
    final Color backgroundColor = isDark ? const Color(0xFF0F172A) : palette.background;
    final Color surfaceColor = isDark ? const Color(0xFF1E293B) : palette.surface;
    final Color textColorPrimary = isDark ? Colors.white : palette.textPrimary;
    final Color textColorSecondary = isDark ? const Color(0xFF94A3B8) : palette.textSecondary;

    return ThemeData(
      brightness: brightness,
      primaryColor: palette.primary,
      scaffoldBackgroundColor: backgroundColor,
      shadowColor: isDark ? Colors.black.withValues(alpha: 0.5) : Colors.black.withValues(alpha: 0.08),
      
      // Theme Extensions
      extensions: [
        isDark ? DeskReliefColors.dark : DeskReliefColors.light,
      ],

      // Card Standardizasyonu
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: isDark ? 2 : 1,
        shadowColor: isDark ? Colors.black.withValues(alpha: 0.4) : Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      
      // iOS Karakteri - Ripple Efektlerini kapatıyoruz
      splashColor: Colors.transparent, 
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,

      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.primary,
        brightness: brightness,
        primary: palette.primary,
        secondary: palette.secondary,
        surface: surfaceColor,
        surfaceContainer: isDark ? const Color(0xFF1E293B) : Colors.white,
        surfaceContainerHigh: isDark ? const Color(0xFF334155) : const Color(0xFFF8FAFC),
        error: palette.error,
        onSurface: textColorPrimary,
      ),

      // iOS Karakteri - Sayfa Geçiş Animasyonları
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: palette.primary,
          foregroundColor: Colors.white,
          textStyle: AppTypography.labelLarge(context),
          elevation: 0, // Flat iOS görünümü
          splashFactory: NoSplash.splashFactory, // Ripple kapalı
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28), // Standardized with buttons
          ),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF1E293B) : palette.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: palette.primary, width: 2),
        ),
      ),
      
      textTheme: AppTypography.buildTextTheme(context).copyWith(
        displayLarge: AppTypography.displayLarge(context).copyWith(color: palette.primary),
        headlineLarge: AppTypography.headlineLarge(context).copyWith(color: textColorPrimary),
        headlineMedium: AppTypography.headlineMedium(context).copyWith(color: textColorPrimary),
        bodyLarge: AppTypography.bodyLarge(context).copyWith(color: textColorSecondary),
        bodyMedium: AppTypography.bodyMedium(context).copyWith(color: textColorSecondary),
        labelLarge: AppTypography.labelLarge(context).copyWith(color: palette.primary),
        labelSmall: AppTypography.labelSmall(context).copyWith(color: palette.primary),
      ),
    );
  }
}

