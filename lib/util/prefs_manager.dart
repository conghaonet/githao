import 'dart:convert';

import 'package:githao_v2/network/entity/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'string_extension.dart';

class PrefsManager {
  static const _keyUsernames = 'usernames';
  static const _keyToken = 'token';
  static const _keyUserPrefix = 'user_entity_';

  /// 请求限制次数
  static const _keyRateLimit = 'x-ratelimit-limit';

  /// 请求限制使用次数
  static const _keyRateLimitUsed = 'x-ratelimit-used';

  /// 请求次数的重置时间
  static const _keyRateLimitReset = 'x-ratelimit-reset';

  late SharedPreferences _prefs;
  bool initialized = false;

  SharedPreferences get prefs => _prefs;
  static final PrefsManager _prefsManager = PrefsManager._internal();

  factory PrefsManager() => _prefsManager;

  PrefsManager._internal();

  Future<void> init() async {
    if (initialized == false) {
      _prefs = await SharedPreferences.getInstance();
      initialized = true;
    }
  }

  String? getToken() => _prefs.getString(_keyToken);

  Future<bool> setToken(String token) => _prefs.setString(_keyToken, token);

  /// return: {username1: token, username2: token}
  Map<String, String> getUsernames() {
    final jsonString = _prefs.getString(_keyUsernames) ?? '{}';
    return Map.castFrom(jsonDecode(jsonString));
  }

  /// [usernames]: {username1: token, username2: token}
  Future<bool> _setUsernames(Map<String, String> usernames) {
    return _prefs.setString(_keyUsernames, jsonEncode(usernames));
  }

  /// [username] is [UserEntity.login]
  UserEntity? getUser({String? username}) {
    final String lastUsername = username ??
        getUsernames()
            .entries
            .firstWhere((element) => element.value == getToken(), orElse: () => new MapEntry<String, String>('', ''))
            .key;
    String? value = _prefs.getString('$_keyUserPrefix$lastUsername') ?? '';
    if (value.isNotEmpty) {
      return UserEntity.fromJson(jsonDecode(value));
    } else {
      return null;
    }
  }

  Future<bool> setUser(UserEntity userEntity, {String? token}) async {
    if (!token.isNullOrEmpty()) {
      final Map<String, String> usernames = getUsernames();
      usernames[userEntity.login!] = token!;
      await _setUsernames(usernames);
    }
    return _prefs.setString('$_keyUserPrefix${userEntity.login}', jsonEncode(userEntity));
  }

  Future<bool> removeUser(String username) async {
    await _prefs.remove('$_keyUserPrefix$username');
    final Map<String, String> usernames = getUsernames();
    if (usernames[username] == getToken()) {
      await _prefs.remove(_keyToken);
    }
    usernames.remove(username);
    return _setUsernames(usernames);
  }

  int? getRateLimit() => _prefs.getInt(_keyRateLimit);

  Future<bool> setRateLimit(int limit) => _prefs.setInt(_keyRateLimit, limit);

  int? getRateLimitUsed() => _prefs.getInt(_keyRateLimitUsed);

  Future<bool> setRateLimitUsed(int used) => _prefs.setInt(_keyRateLimitUsed, used);

  int? getRateLimitReset() => _prefs.getInt(_keyRateLimitReset);

  Future<bool> setRateLimitReset(int reset) => _prefs.setInt(_keyRateLimitReset, reset);
}

PrefsManager prefsManager = PrefsManager();
