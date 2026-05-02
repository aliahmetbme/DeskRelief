import 'package:flutter/material.dart';

@immutable
class DeskReliefColors extends ThemeExtension<DeskReliefColors> {
  final Color? alertBackground;
  final Color? alertText;
  final Color? alertBorder;
  final Color? successBackground;
  final Color? successText;
  final Color? warningBackground;
  final Color? warningText;
  final Color? cardShadowColor;
  final Color? success;
  final Color? warning;
  final Color? error;

  const DeskReliefColors({
    required this.alertBackground,
    required this.alertText,
    required this.alertBorder,
    required this.successBackground,
    required this.successText,
    required this.warningBackground,
    required this.warningText,
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
    Color? successBackground,
    Color? successText,
    Color? warningBackground,
    Color? warningText,
    Color? cardShadowColor,
    Color? success,
    Color? warning,
    Color? error,
  }) {
    return DeskReliefColors(
      alertBackground: alertBackground ?? this.alertBackground,
      alertText: alertText ?? this.alertText,
      alertBorder: alertBorder ?? this.alertBorder,
      successBackground: successBackground ?? this.successBackground,
      successText: successText ?? this.successText,
      warningBackground: warningBackground ?? this.warningBackground,
      warningText: warningText ?? this.warningText,
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
      successBackground: Color.lerp(successBackground, other.successBackground, t),
      successText: Color.lerp(successText, other.successText, t),
      warningBackground: Color.lerp(warningBackground, other.warningBackground, t),
      warningText: Color.lerp(warningText, other.warningText, t),
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
    successBackground: Color(0xFFDFFFD6),
    successText: Color(0xFF1E5631),
    warningBackground: Color(0xFFFFF3CD),
    warningText: Color(0xFF856404),
    cardShadowColor: Color(0x1A000000),
    success: Color(0xFF10B981),
    warning: Color(0xFFF59E0B),
    error: Color(0xFFEF4444),
  );

  // Preset for Medical Theme (Current Dark - Slate)
  static const medical = DeskReliefColors(
    alertBackground: Color(0xFF450A0A),
    alertText: Color(0xFFFECACA),
    alertBorder: Color(0x33EF4444),
    successBackground: Color(0xFF1B3B2B),
    successText: Color(0xFF4ADE80),
    warningBackground: Color(0xFF2D2400),
    warningText: Color(0xFFFFCC00),
    cardShadowColor: Color(0x4D000000),
    success: Color(0xFF34D399),
    warning: Color(0xFFFBBF24),
    error: Color(0xFFF87171),
  );

  // Preset for Dark Theme (True Black)
  static const dark = DeskReliefColors(
    alertBackground: Color(0xFF2D0606),
    alertText: Color(0xFFF87171),
    alertBorder: Color(0x33EF4444),
    successBackground: Color(0xFF122619),
    successText: Color(0xFF30D158),
    warningBackground: Color(0xFF262100),
    warningText: Color(0xFFFFD60A),
    cardShadowColor: Color(0xFF000000),
    success: Color(0xFF30D158), // iOS Green
    warning: Color(0xFFFFD60A), // iOS Yellow
    error: Color(0xFFFF453A), // iOS Red
  );
}

class AppColors {
  static const Color primary = Color(0xFF6366F1);
  static const Color secondary = Color(0xFF14B8A6);
}
