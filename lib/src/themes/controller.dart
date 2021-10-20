import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppTheme with ChangeNotifier {
  late ThemeMode _currentThemeMode;
  late bool _isDark;

  AppTheme() {
    _currentThemeMode = ThemeMode.light;
    _isDark = _currentThemeMode != ThemeMode.system
      ? _currentThemeMode == ThemeMode.dark
      : SchedulerBinding.instance?.window.platformBrightness == Brightness.dark;
  }

  ThemeMode get themeMode => _currentThemeMode;
  bool get isDark => _isDark;

  void useLightThemeMode() {
    _currentThemeMode = ThemeMode.light;
    _isDark = false;
    notifyListeners();
  }

  void useDarkThemeMode() {
    _currentThemeMode = ThemeMode.dark;
    _isDark = true;
    notifyListeners();
  }

  void useSystemThemeMode() {
    _currentThemeMode = ThemeMode.system;
    _isDark = SchedulerBinding.instance?.window.platformBrightness == Brightness.dark;
    notifyListeners();
  }

  void switchTheme() {
    _isDark = !_isDark;
    _currentThemeMode = _isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

AppTheme currentAppTheme = AppTheme();
