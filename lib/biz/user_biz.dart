import 'dart:convert';

import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/utils/sp_util.dart';
import 'package:githao/utils/string_util.dart';

class UserBiz {
  static Future<UserEntity> login(username, password) async {
    String authBasic = _getCredentialsBasic(username, password);
    return ApiService.login(authBasic).then((authorizationEntity) async {
      SpUtil.setUserName(username);
      SpUtil.setGitHubAuthorizationBasic(authBasic);
      SpUtil.setGitHubAuthorizationToken('token ${authorizationEntity.token}');
    }).then<UserEntity>((_) => getUser(forceRefresh: true));
  }
  static String _getCredentialsBasic(String username, String password) {
    final bytes = latin1.encode("$username:$password");
    final encoded = base64Encode(bytes);
    return "Basic " + encoded;
  }
  static Future<UserEntity> getUser({bool forceRefresh = false}) async {
    if(forceRefresh) {
      return ApiService.getAuthenticatedUser().then<UserEntity>((userEntity) async {
        SpUtil.setUserEntity(userEntity);
        return userEntity;
      });
    } else {
      UserEntity _entity = SpUtil.getUserEntity();

      if(_entity != null) {
        return _entity;
      } else {
        String _basic = SpUtil.getGitHubAuthorizationBasic();
        if(StringUtil.isNotEmpty(_basic)) {
          return ApiService.getAuthenticatedUser().then<UserEntity>((userEntity) async {
            SpUtil.setUserEntity(userEntity);
            return userEntity;
          });
        } else {
          return null;
        }
      }
    }
  }
}