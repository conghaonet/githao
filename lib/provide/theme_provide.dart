import 'package:flutter/material.dart';

class ThemeProvide with ChangeNotifier {
  int _themeIndex=5;
  int get themeIndex => _themeIndex;
  void changeTheme(int themeIndex) {
    if(themeIndex <0 || themeIndex>=Colors.primaries.length) {
      this._themeIndex = 0;
    } else {
      this._themeIndex = themeIndex;
    }
    notifyListeners();
  }
}