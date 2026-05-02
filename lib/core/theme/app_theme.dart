import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_palettes.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData buildTheme(BuildContext context, AppPalette palette, {bool isDark = false, bool isTrueDark = false}) {
    final Brightness brightness = (isDark || isTrueDark) ? Brightness.dark : Brightness.light;
    
    // Background and Surface logic
    // Medical (isDark): Slate-based depth
    // Dark (isTrueDark): True Black
    final Color backgroundColor = isTrueDark 
        ? Colors.black 
        : (isDark ? const Color(0xFF0F172A) : palette.background);
        
    final Color surfaceColor = isTrueDark 
        ? const Color(0xFF1C1C1E) 
        : (isDark ? const Color(0xFF1E293B) : palette.surface);
        
    final Color textColorPrimary = (isDark || isTrueDark) ? Colors.white : palette.textPrimary;
    final Color textColorSecondary = (isDark || isTrueDark) ? const Color(0xFF94A3B8) : palette.textSecondary;

    return ThemeData(
      brightness: brightness,
      primaryColor: palette.primary,
      scaffoldBackgroundColor: backgroundColor,
      shadowColor: (isDark || isTrueDark) ? Colors.black.withValues(alpha: 0.5) : Colors.black.withValues(alpha: 0.08),
      
      // Theme Extensions
      extensions: [
        isTrueDark 
            ? DeskReliefColors.dark 
            : (isDark ? DeskReliefColors.medical : DeskReliefColors.light),
      ],

      // Card Standardization
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: (isDark || isTrueDark) ? 2 : 1,
        surfaceTintColor: Colors.transparent,
        shadowColor: (isDark || isTrueDark) ? Colors.black.withValues(alpha: 0.4) : Colors.black.withValues(alpha: 0.05),
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
        surfaceContainer: surfaceColor,
        surfaceContainerHigh: isTrueDark ? const Color(0xFF2C2C2E) : (isDark ? const Color(0xFF334155) : const Color(0xFFF8FAFC)),
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
          elevation: 0, 
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
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
        displayLarge: AppTypography.displayLarge(context).copyWith(color: (isDark || isTrueDark) ? Colors.white : palette.primary),
        headlineLarge: AppTypography.headlineLarge(context).copyWith(color: textColorPrimary),
        headlineMedium: AppTypography.headlineMedium(context).copyWith(color: textColorPrimary),
        bodyLarge: AppTypography.bodyLarge(context).copyWith(color: textColorSecondary),
        bodyMedium: AppTypography.bodyMedium(context).copyWith(color: textColorSecondary),
        labelLarge: AppTypography.labelLarge(context).copyWith(color: (isDark || isTrueDark) ? Colors.white : palette.primary),
        labelSmall: AppTypography.labelSmall(context).copyWith(color: (isDark || isTrueDark) ? Colors.white : palette.primary),
      ),
    );
  }
}
