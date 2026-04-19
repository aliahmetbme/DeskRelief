import 'package:flutter/material.dart';
import 'app_palettes.dart';

class ThemeProvider extends ChangeNotifier {
  AppPalette _currentPalette = DeskReliefPalette();
  ThemeMode _themeMode = ThemeMode.system;

  AppPalette get palette => _currentPalette;
  ThemeMode get themeMode => _themeMode;

  void setTheme(AppPalette newPalette) {
    if (_currentPalette == newPalette) return;
    _currentPalette = newPalette;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }
}
