import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/token_request_model.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/utils/sp_util.dart';
import 'package:githao/utils/string_util.dart';

class UserBiz {
  static Future<UserEntity> loginOauth(TokenRequestModel model) async {
    return ApiService.accessToken(model).then((authorizationEntity) async {
      SpUtil.setToken(authorizationEntity.accessToken);
    }).then<UserEntity>((_) => getUser(forceRefresh: true));
  }

  static Future<UserEntity> getUser({bool forceRefresh = false}) async {
    if(forceRefresh) {
      return ApiService.getAuthenticatedUser().then<UserEntity>((userEntity) async {
        SpUtil.setUserName(userEntity.login);
        SpUtil.setUserEntity(userEntity);
        return userEntity;
      });
    } else {
      UserEntity _entity = SpUtil.getUserEntity();

      if(_entity != null) {
        return _entity;
      } else {
        String token = SpUtil.getToken();
        if(StringUtil.isNotEmpty(token)) {
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