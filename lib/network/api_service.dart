import 'package:dio/dio.dart';
import 'package:githao/utils/shared_preferences.dart';

import 'package:githao/network/entity/authorization_entity.dart';
import 'package:githao/network/entity/authorization_post.dart';
import 'entity/user_entity.dart';
import 'dio_client.dart';

class ApiService {
  static Future<AuthorizationEntity> login(String credentialsBasic) async {
    Options options = Options(headers: {"Authorization": credentialsBasic});
    Response<Map<String, dynamic>> response = await dioClient.dio.post("/authorizations", data: AuthorizationPost().toJson(), options: options);
    return AuthorizationEntity.fromJson(response.data);
  }

  static Future<UserEntity> getUser(String username) async {
    Response<Map<String, dynamic>> response = await dioClient.dio.get("/users/$username");
    return UserEntity.fromJson(response.data);
  }

  static Future<UserEntity> getAuthenticatedUser() async {
    Response<Map<String, dynamic>> response = await dioClient.dio.get("/user");
    return UserEntity.fromJson(response.data);
  }
}