import 'package:flutter/material.dart';

class ThemeProvide with ChangeNotifier {
  ThemeData _themeData = ThemeData.light();
  ThemeData get themeData => _themeData;
  void changeTheme(int themeIndex) {
    if(themeIndex >=0 && themeIndex<Colors.primaries.length) {
      this._themeData = ThemeData(
        primarySwatch: Colors.primaries[themeIndex],
        primaryColor: Colors.primaries[themeIndex],
        cursorColor: Colors.primaries[themeIndex], //光标颜色
        accentColor: Colors.primaries[themeIndex][700],
        brightness: Brightness.light,
      );
      notifyListeners();
    }
  }
}