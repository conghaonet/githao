import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvide with ChangeNotifier {
  static const DEFAULT_THEME_INDEX = 0;
  int _themeIndex = DEFAULT_THEME_INDEX;
  int get themeIndex => _themeIndex;

  ThemeData _themeData = ThemeData(
    primarySwatch: Colors.primaries[DEFAULT_THEME_INDEX],
    cursorColor: Colors.primaries[DEFAULT_THEME_INDEX], //光标颜色
  );
  ThemeData get themeData => _themeData;

  SystemUiOverlayStyle _overlayStyle = SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.primaries[DEFAULT_THEME_INDEX], //状态栏背景色
    systemNavigationBarColor: Colors.primaries[DEFAULT_THEME_INDEX], //系统导航栏（虚拟按键）背景色
    statusBarIconBrightness: _getReverseBrightness(Colors.primaries[DEFAULT_THEME_INDEX]),
    statusBarBrightness: ThemeData.estimateBrightnessForColor(Colors.primaries[DEFAULT_THEME_INDEX]),
    systemNavigationBarIconBrightness: _getReverseBrightness(Colors.primaries[DEFAULT_THEME_INDEX]),
  );
  SystemUiOverlayStyle get overlayStyle => _overlayStyle;

  /// 状态栏背景的[Brightness]与状态栏图标的[Brightness]相反，
  /// 如果状态栏背景是[Brightness.dark]，则状态栏图标是[Brightness.light]，
  /// 根据[MaterialColor]得到的[Brightness]是状态栏背景的，这里需要转换为状态栏图标的[Brightness]
  static Brightness _getReverseBrightness( materialColor) {
    var reverseBrightness = ThemeData.estimateBrightnessForColor(materialColor);
    return reverseBrightness == Brightness.dark ? Brightness.light : Brightness.dark;
  }

  void changeTheme(int themeIndex) {
    if(themeIndex >= 0 && themeIndex < Colors.primaries.length) {
      this._themeIndex = themeIndex;
      this._themeData = ThemeData(
        primarySwatch: Colors.primaries[themeIndex],
        cursorColor: Colors.primaries[themeIndex], //光标颜色
      );
      _overlayStyle = SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.primaries[themeIndex], //状态栏背景色
        systemNavigationBarColor: Colors.primaries[themeIndex], //系统导航栏（虚拟按键）背景色
        statusBarIconBrightness: _getReverseBrightness(Colors.primaries[themeIndex]),
        statusBarBrightness: ThemeData.estimateBrightnessForColor(Colors.primaries[themeIndex]),
        systemNavigationBarIconBrightness: _getReverseBrightness(Colors.primaries[themeIndex]),
      );
      notifyListeners();
    }
  }
}