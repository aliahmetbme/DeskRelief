import 'dart:math';
import 'package:flutter/material.dart';

class CircularPainIndicator extends StatelessWidget {
  final double value; // 0 to 10
  final String label;
  final Color activeColor;

  const CircularPainIndicator({
    super.key,
    required this.value,
    required this.label,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Arka Plan Işıltısı (Glow)
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: activeColor.withValues(alpha: 0.15),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),

          // Custom Gauge
          CustomPaint(
            size: const Size(260, 260),
            painter: _GaugePainter(
              progress: value / 10,
              activeColor: activeColor,
              backgroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
            ),
          ),

          // İçerik
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value.round().toString(),
                style: theme.textTheme.displayLarge?.copyWith(
                  fontSize: 84,
                  fontWeight: FontWeight.w900,
                  color: activeColor,
                  letterSpacing: -4,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ), // Padding azaltıldı
                decoration: BoxDecoration(
                  color: activeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getIconForValue(value),
                      size: 16, // İkon küçültüldü
                      color: activeColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      label.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 10, // Font boyutu küçültüldü
                        color: activeColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIconForValue(double val) {
    if (val <= 3) return Icons.sentiment_satisfied_alt;
    if (val <= 6) return Icons.sentiment_neutral;
    return Icons.sentiment_very_dissatisfied;
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color backgroundColor;

  _GaugePainter({
    required this.progress,
    required this.activeColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const startAngle = -pi / 2;
    const sweepAngle = 2 * pi;

    // Arka plan dairesi
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // İlerleme dairesi
    final progressPaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    // Gölge efekti (Neumorphic Glow)
    final shadowPaint = Paint()
      ..color = activeColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * progress,
      false,
      shadowPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.activeColor != activeColor;
}
