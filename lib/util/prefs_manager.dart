import 'dart:convert';

import 'package:githao_v2/entity/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static const keyToken = 'token';
  static const keyUser = 'user_entity';
  late SharedPreferences _prefs;
  bool initialized = false;
  SharedPreferences get prefs => _prefs;
  static final PrefsManager _prefsManager = PrefsManager._internal();
  factory PrefsManager() => _prefsManager;
  PrefsManager._internal();

  Future<void> init() async {
    if(initialized == false) {
      _prefs = await SharedPreferences.getInstance();
      initialized = true;
    }
  }

  String? getToken() => _prefs.getString(keyToken);
  Future<bool> setUserName(String token) => _prefs.setString(keyToken, token);

  UserEntity? getUser() {
    String? value = _prefs.getString(keyUser);
    if(value!.isNotEmpty) {
      dynamic entity = jsonDecode(value);
      UserEntity userEntity = UserEntity.fromJson(entity);
      return userEntity;
    } else {
      return null;
    }
  }
  Future<bool> setUser(UserEntity userEntity) {
    return _prefs.setString(keyUser, jsonEncode(userEntity));
  }
}

PrefsManager prefsManager = PrefsManager();