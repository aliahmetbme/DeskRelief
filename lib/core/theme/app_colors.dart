import 'package:flutter/material.dart';

@immutable
class DeskReliefColors extends ThemeExtension<DeskReliefColors> {
  final Color? alertBackground;
  final Color? alertText;
  final Color? alertBorder;
  final Color? cardShadowColor;
  final Color? success;
  final Color? warning;
  final Color? error;

  const DeskReliefColors({
    required this.alertBackground,
    required this.alertText,
    required this.alertBorder,
    required this.cardShadowColor,
    required this.success,
    required this.warning,
    required this.error,
  });

  @override
  DeskReliefColors copyWith({
    Color? alertBackground,
    Color? alertText,
    Color? alertBorder,
    Color? cardShadowColor,
    Color? success,
    Color? warning,
    Color? error,
  }) {
    return DeskReliefColors(
      alertBackground: alertBackground ?? this.alertBackground,
      alertText: alertText ?? this.alertText,
      alertBorder: alertBorder ?? this.alertBorder,
      cardShadowColor: cardShadowColor ?? this.cardShadowColor,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
    );
  }

  @override
  DeskReliefColors lerp(ThemeExtension<DeskReliefColors>? other, double t) {
    if (other is! DeskReliefColors) return this;
    return DeskReliefColors(
      alertBackground: Color.lerp(alertBackground, other.alertBackground, t),
      alertText: Color.lerp(alertText, other.alertText, t),
      alertBorder: Color.lerp(alertBorder, other.alertBorder, t),
      cardShadowColor: Color.lerp(cardShadowColor, other.cardShadowColor, t),
      success: Color.lerp(success, other.success, t),
      warning: Color.lerp(warning, other.warning, t),
      error: Color.lerp(error, other.error, t),
    );
  }

  // Preset for Light Mode
  static const light = DeskReliefColors(
    alertBackground: Color(0xFFFFF1F1),
    alertText: Color(0xFF991B1B),
    alertBorder: Color(0x19EF4444),
    cardShadowColor: Color(0x1A000000), // 10% Black
    success: Color(0xFF10B981),
    warning: Color(0xFFF59E0B),
    error: Color(0xFFEF4444),
  );

  // Preset for Dark Mode
  static const dark = DeskReliefColors(
    alertBackground: Color(0xFF450A0A),
    alertText: Color(0xFFFECACA),
    alertBorder: Color(0x33EF4444),
    cardShadowColor: Color(0x4D000000), // 30% Black
    success: Color(0xFF34D399),
    warning: Color(0xFFFBBF24),
    error: Color(0xFFF87171),
  );
}

class AppColors {
  // Legacy support or quick access if needed, but ThemeExtension is preferred
  static const Color primary = Color(0xFF6366F1);
  static const Color secondary = Color(0xFF14B8A6);
}

