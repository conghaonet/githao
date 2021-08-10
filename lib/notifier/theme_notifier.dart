
import 'package:flutter/material.dart';
import 'package:githao/util/prefs_manager.dart';

class ThemeNotifier extends ChangeNotifier {
  static final ThemeNotifier _themeNotifier = ThemeNotifier._internal();
  factory ThemeNotifier() => _themeNotifier;
  ThemeNotifier._internal();
  ThemeMode get themeMode => prefsManager.initialized ? prefsManager.getThemeMode() : ThemeMode.system;
  void notify() {
    notifyListeners();
  }
}
ThemeNotifier themeNotifier = ThemeNotifier();