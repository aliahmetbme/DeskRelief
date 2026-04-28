import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_palettes.dart';

class ThemeProvider extends ChangeNotifier {
  AppPalette _currentPalette = DeskReliefPalette();
  ThemeMode _themeMode = ThemeMode.system;

  AppPalette get palette => _currentPalette;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? modeStr = prefs.getString('themeMode');
    if (modeStr != null) {
      if (modeStr == 'dark') {
        _themeMode = ThemeMode.dark;
      } else if (modeStr == 'light') {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.system;
      }
      notifyListeners();
    }
  }

  void setTheme(AppPalette newPalette) {
    if (_currentPalette == newPalette) return;
    _currentPalette = newPalette;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String modeStr = 'system';
    if (mode == ThemeMode.dark) modeStr = 'dark';
    if (mode == ThemeMode.light) modeStr = 'light';
    await prefs.setString('themeMode', modeStr);
  }
}
