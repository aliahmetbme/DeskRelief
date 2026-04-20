import 'package:flutter/material.dart';

class GradientSliderTrackShape extends SliderTrackShape with BaseSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Paint fillPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF006E28), // Koyu Yeşil
          Color(0xFFFBC02D), // Sarı/Altın
          Color(0xFFBA1A1A), // Kırmızı
        ],
      ).createShader(trackRect);

    final Radius trackRadius = Radius.circular(trackRect.height / 2);

    // Tüm track'i çiziyoruz
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, trackRadius),
      fillPaint,
    );
  }
}
