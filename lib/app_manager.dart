import 'package:githao_v2/util/prefs_manager.dart';

class AppManager {
  static final AppManager _appManager = AppManager._internal();
  factory AppManager() {
    return _appManager;
  }
  AppManager._internal() {
    prefsManager.init();
  }
  Future<void> init() async {
    await prefsManager.init();
  }
}

AppManager appManager = AppManager();