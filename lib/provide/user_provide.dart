import 'package:flutter/widgets.dart';
import 'package:githao/network/entity/user_entity.dart';

class UserProvide with ChangeNotifier {
  UserEntity _userEntity;
  UserEntity get user => _userEntity;
  UserProvide();
  void updateUser(UserEntity entity) {
    this._userEntity = entity;
    notifyListeners();
  }
}