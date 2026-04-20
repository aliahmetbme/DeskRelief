import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  // ─── Responsive Scaling Logic ──────────────────────────────────────────────
  // Baseline width (iPhone 13/14/15 size)
  static const double _baselineWidth = 390.0;

  // Calculates a responsive font size based on screen width
  // it uses a clamp to prevent text from becoming illegible or overly huge.
  static double _responsiveSize(BuildContext context, double baseSize) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    // Scale factor: how much the current width deviates from baseline
    final double scaleFactor = screenWidth / _baselineWidth;
    
    // We clamp the scaling to a safe range (0.8x to 1.25x)
    // to ensure layout integrity on extreme device sizes.
    return (baseSize * scaleFactor).clamp(baseSize * 0.85, baseSize * 1.25);
  }

  // ─── Dynamic TextTheme Generator ───────────────────────────────────────────
  // This builds a full TextTheme where every style is automatically scaled.
  static TextTheme buildTextTheme(BuildContext context) {
    return TextTheme(
      displayLarge: displayLarge(context),
      headlineLarge: headlineLarge(context),
      headlineMedium: headlineMedium(context),
      bodyLarge: bodyLarge(context),
      bodyMedium: bodyMedium(context),
      labelLarge: labelLarge(context),
      labelSmall: labelSmall(context),
    );
  }

  // ─── Scaled Styles ─────────────────────────────────────────────────────────

  static TextStyle displayLarge(BuildContext context) => GoogleFonts.manrope(
        fontSize: _responsiveSize(context, 32),
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        height: 1.2,
      );

  static TextStyle headlineLarge(BuildContext context) => GoogleFonts.inter(
        fontSize: _responsiveSize(context, 32),
        fontWeight: FontWeight.bold,
      );

  static TextStyle headlineMedium(BuildContext context) => GoogleFonts.inter(
        fontSize: _responsiveSize(context, 28),
        fontWeight: FontWeight.w600,
      );

  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.inter(
        fontSize: _responsiveSize(context, 18),
        fontWeight: FontWeight.normal,
        height: 1.6,
      );

  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.inter(
        fontSize: _responsiveSize(context, 14),
        fontWeight: FontWeight.normal,
      );

  static TextStyle labelLarge(BuildContext context) => GoogleFonts.manrope(
        fontSize: _responsiveSize(context, 18),
        fontWeight: FontWeight.bold,
      );
      
  static TextStyle labelSmall(BuildContext context) => GoogleFonts.manrope(
        fontSize: _responsiveSize(context, 16),
        fontWeight: FontWeight.bold,
        letterSpacing: -0.3,
      );
}
