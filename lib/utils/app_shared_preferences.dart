import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static SharedPreferences _sp;
  AppSharedPreferences._internal();
  static final AppSharedPreferences _appSP = AppSharedPreferences._internal();
  factory AppSharedPreferences() {
    return _appSP;
  }
  Future<void> init() async {
    if(_sp == null) {
      _sp = await SharedPreferences.getInstance();
    }
  }

  // 判断是否存在数据
  bool hasKey(String key) => _sp.containsKey(key);

  Set<String> getKeys() => _sp.getKeys();

  dynamic get(String key) => _sp.get(key);

  Future<bool> remove(String key) => _sp.remove(key);

  Future<bool> clear() => _sp.clear();

  String getString(String key) => _sp.getString(key);
  Future<bool> setString(String key, String value) => _sp.setString(key, value);

  bool getBool(String key) => _sp.getBool(key);
  Future<bool> setBool(String key, bool value) => _sp.setBool(key, value);

  int getInt(String key) => _sp.getInt(key);
  Future<bool> setInt(String key, int value) => _sp.setInt(key, value);

  double getDouble(String key) => _sp.getDouble(key);
  Future<bool> setDouble(String key, double value) => _sp.setDouble(key, value);

  List<String> getStringList(String key) => _sp.getStringList(key);
  Future<bool> setStringList(String key, List<String> value) => _sp.setStringList(key, value);

}

AppSharedPreferences appSP = AppSharedPreferences();