import 'dart:convert';

import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/utils/shared_preferences.dart';

class UserBiz {
  static Future logout() async {
    SpUtil spUtil = await SpUtil.getInstance();
    spUtil.remove(SharedPreferencesKeys.userName);
    spUtil.remove(SharedPreferencesKeys.gitHubAuthorizationBasic);
    spUtil.remove(SharedPreferencesKeys.gitHubAuthorizationToken);
    spUtil.remove(SharedPreferencesKeys.userEntity);
  }
  static Future<UserEntity> login(username, password) async {
    String authBasic = _getCredentialsBasic(username, password);
    return ApiService.login(authBasic).then((authorizationEntity) async {
      SpUtil spUtil = await SpUtil.getInstance();
      spUtil.putString(SharedPreferencesKeys.userName, username);
      spUtil.putString(SharedPreferencesKeys.gitHubAuthorizationBasic, authBasic);
      spUtil.putString(SharedPreferencesKeys.gitHubAuthorizationToken, 'token ${authorizationEntity.token}');
    }).then<UserEntity>((_) => getUser(forceRefresh: true));
  }
  static String _getCredentialsBasic(String username, String password) {
    final bytes = latin1.encode("$username:$password");
    final encoded = base64Encode(bytes);
    return "Basic " + encoded;
  }
  static Future<UserEntity> getUser({bool forceRefresh = false}) async {
    SpUtil spUtil = await SpUtil.getInstance();
    if(forceRefresh) {
      return ApiService.getAuthenticatedUser().then<UserEntity>((userEntity) async {
        await spUtil.putString(SharedPreferencesKeys.userEntity, jsonEncode(userEntity));
        return userEntity;
      });
    } else {
      if(spUtil.hasKey(SharedPreferencesKeys.userEntity)) {
        String strJson = spUtil.getString(SharedPreferencesKeys.userEntity);
        Map<String ,dynamic> map = jsonDecode(strJson);
        return UserEntity.fromJson(map);
      } else {
        if(spUtil.hasKey(SharedPreferencesKeys.gitHubAuthorizationBasic)) {
          return ApiService.getAuthenticatedUser().then<UserEntity>((userEntity) async {
            await spUtil.putString(SharedPreferencesKeys.userEntity, jsonEncode(userEntity));
            return userEntity;
          });
        } else {
          return null;
        }
      }
    }
  }
}