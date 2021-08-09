
import 'package:flutter/material.dart';
import 'package:githao/util/prefs_manager.dart';

class ThemeNotifier extends ChangeNotifier {
  // static late ThemeMode _themeMode = ThemeMode.system;
  static final ThemeNotifier _themeNotifier = ThemeNotifier._internal();
  factory ThemeNotifier() => _themeNotifier;
  ThemeNotifier._internal();
  ThemeMode get themeMode => prefsManager.initialized ? prefsManager.getThemeMode() : ThemeMode.system;
  void notify() {
    // _themeMode = prefsManager.getThemeMode();
    notifyListeners();
  }
}
ThemeNotifier themeNotifier = ThemeNotifier();