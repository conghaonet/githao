import 'dart:convert';
import 'package:githao/network/entity/user_entity.dart';

import 'app_shared_preferences.dart';

class SpUtil {
  static String searchHistory = 'searchHistory';
  static String userName = 'userName';
  static String themeIndex = 'themeIndex';
  static String language = 'language';
  static String userEntity = 'userEntity';
  static String token = 'token';

  static List<String> getSearchHistory() => appSP.getStringList(searchHistory);
  static Future<bool> setSearchHistory(List<String> value) => appSP.setStringList(searchHistory, value);
  static Future<bool> removeSearchHistory() => appSP.remove(searchHistory);

  static String getUserName() => appSP.getString(userName);
  static Future<bool> setUserName(String value) => appSP.setString(userName, value);

  static String getToken() => appSP.getString(token);
  static Future<bool> setToken(String value) => appSP.setString(token, value);

  static int getThemeIndex() => appSP.getInt(themeIndex);
  static Future<bool> setThemeIndex(int value) => appSP.setInt(themeIndex, value);

  static String getLanguage() => appSP.getString(language);
  static Future<bool> setLanguage(String value) => appSP.setString(language, value);

  static UserEntity getUserEntity() {
    String json = appSP.getString(userEntity);
    if(json != null && json.isNotEmpty) {
      dynamic entity = jsonDecode(json);
      UserEntity userEntity = UserEntity.fromJson(entity);
      return userEntity;
    } else {
      return null;
    }
  }
  static Future<bool> setUserEntity(UserEntity entity) {
    return appSP.setString(userEntity, jsonEncode(entity));
  }

  static void logout() {
    appSP.remove(userName);
    appSP.remove(token);
    appSP.remove(userEntity);
  }

}