import 'package:flutter/material.dart';
import 'package:githao/util/prefs_manager.dart';

class AppManager {
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  static final AppManager _appManager = AppManager._internal();

  factory AppManager() {
    return _appManager;
  }
  AppManager._internal() {
    prefsManager.init();
  }
  Future<void> init() async {
    if(!_isInitialized) {
      await prefsManager.init();
    }
    _isInitialized = true;
  }
}

final AppManager appManager = AppManager();
final GlobalKey<NavigatorState> navigatorState = new GlobalKey();

