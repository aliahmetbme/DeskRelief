import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_palettes.dart';

enum AppThemeMode { light, medical, dark, system }

class ThemeProvider extends ChangeNotifier {
  AppPalette _currentPalette = DeskReliefPalette();
  AppThemeMode _themeMode = AppThemeMode.system;

  AppPalette get palette => _currentPalette;
  AppThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? modeStr = prefs.getString('themeModeV2'); // New key to avoid conflicts
    if (modeStr != null) {
      _themeMode = AppThemeMode.values.firstWhere(
        (e) => e.name == modeStr,
        orElse: () => AppThemeMode.system,
      );
    } else {
      // Legacy check
      String? oldMode = prefs.getString('themeMode');
      if (oldMode == 'dark') {
        _themeMode = AppThemeMode.medical;
      } else if (oldMode == 'light') {
        _themeMode = AppThemeMode.light;
      } else {
        _themeMode = AppThemeMode.system;
      }
    }
    notifyListeners();
  }

  void setTheme(AppPalette newPalette) {
    if (_currentPalette == newPalette) return;
    _currentPalette = newPalette;
    notifyListeners();
  }

  void setThemeMode(AppThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeModeV2', mode.name);
  }
}
