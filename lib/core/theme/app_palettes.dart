import 'package:flutter/material.dart';

/// Temel renk paketini tanımlayan soyut sınıf (Interface)
abstract class AppPalette {
  Color get primary;
  Color get secondary;
  Color get background;
  Color get surface;
  Color get error;
  Color get textPrimary;
  Color get textSecondary;
}

class DeskReliefPalette implements AppPalette {
  @override
  Color get primary => const Color(0xFF007AFF);
  
  @override
  Color get secondary => const Color(0xFFE2E2E7);
  
  @override
  Color get background => const Color(0xFFF2F2F7);
  
  @override
  Color get surface => const Color(0xFFFFFFFF);
  
  @override
  Color get error => const Color(0xFFBA1A1A);
  
  @override
  Color get textPrimary => const Color(0xFF1A1C1F);
  
  @override
  Color get textSecondary => const Color(0xFF414755);
}

class IndigoPalette implements AppPalette {
  @override
  Color get primary => const Color(0xFF5C6BC0); // Indigo 400
  
  @override
  Color get secondary => const Color(0xFF26A69A); // Teal 400
  
  @override
  Color get background => const Color(0xFFF2F2F7); // iOS System Background
  
  @override
  Color get surface => const Color(0xFFFFFFFF);
  
  @override
  Color get error => const Color(0xFFFF3B30); // iOS Red
  
  @override
  Color get textPrimary => const Color(0xFF000000); // iOS Label
  
  @override
  Color get textSecondary => const Color(0xFF3C3C43).withOpacity(0.6); // iOS Secondary Label
}

class TealPalette implements AppPalette {
  @override
  Color get primary => const Color(0xFF009688); // Teal
  
  @override
  Color get secondary => const Color(0xFFFF9800); // Orange
  
  @override
  Color get background => const Color(0xFFF2F2F7);
  
  @override
  Color get surface => const Color(0xFFFFFFFF);
  
  @override
  Color get error => const Color(0xFFFF3B30);
  
  @override
  Color get textPrimary => const Color(0xFF000000);
  
  @override
  Color get textSecondary => const Color(0xFF3C3C43).withOpacity(0.6);
}
