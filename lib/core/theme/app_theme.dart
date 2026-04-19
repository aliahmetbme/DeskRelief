import 'package:flutter/material.dart';
import 'app_palettes.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData buildTheme(AppPalette palette, {bool isDark = false}) {
    final Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    
    // Basit bir Dark/Light ayrımı yapıyoruz, palette renkleri üzerine ezilebilir:
    final Color backgroundColor = isDark ? const Color(0xFF000000) : palette.background;
    final Color surfaceColor = isDark ? const Color(0xFF1C1C1E) : palette.surface;
    final Color textColorPrimary = isDark ? Colors.white : palette.textPrimary;
    final Color textColorSecondary = isDark ? const Color(0xFFEBEBF5).withOpacity(0.6) : palette.textSecondary;

    return ThemeData(
      brightness: brightness,
      primaryColor: palette.primary,
      scaffoldBackgroundColor: backgroundColor,
      
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
        error: palette.error,
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
          textStyle: AppTypography.labelLarge,
          elevation: 0, // Flat iOS görünümü
          splashFactory: NoSplash.splashFactory, // Ripple kapalı
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: palette.primary, width: 2),
        ),
      ),
      
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge.copyWith(color: palette.primary),
        headlineLarge: AppTypography.headlineLarge.copyWith(color: textColorPrimary),
        headlineMedium: AppTypography.headlineMedium.copyWith(color: textColorPrimary),
        bodyLarge: AppTypography.bodyLarge.copyWith(color: textColorSecondary),
        bodyMedium: AppTypography.bodyMedium.copyWith(color: textColorSecondary),
        labelLarge: AppTypography.labelLarge.copyWith(color: palette.primary),
        labelSmall: AppTypography.labelSmall.copyWith(color: palette.primary),
      ),
    );
  }
}
