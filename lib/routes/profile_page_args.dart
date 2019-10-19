import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/utils/string_util.dart';

class ProfilePageArgs {
  final UserEntity userEntity;
  final String login;
  final String heroTag;

  ProfilePageArgs({
    this.userEntity,
    this.login,
    this.heroTag,
  }): assert(userEntity != null || StringUtil.isNotBlank(login));

}