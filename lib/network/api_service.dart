import 'package:dio/dio.dart';

import 'package:githao/network/entity/authorization_entity.dart';
import 'package:githao/network/entity/authorization_post.dart';
import 'entity/repo_entity.dart';
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

  /// [page] 取值从1开始，表示请求第几页，每页返回30笔数据
  /// [type] Can be one of: all, owner, public, private, member
  /// [sort] Can be one of: created, updated, pushed, full_name
  /// [direction] Can be one of: asc or desc
  static Future<List<RepoEntity>> getRepos({int page=1, String type='all', String sort='full_name', String direction='asc'}) async {
    Map<String, dynamic> parameters = {'page': page, 'type': type, 'sort': sort, 'direction': direction};
    Response<List<dynamic>> response = await dioClient.dio.get("/user/repos", queryParameters: parameters);
    return response.data.map((item) => RepoEntity.fromJson(item)).toList();
  }

  /// [sort] One of created (when the repository was starred) or updated (when it was last pushed to). Default: created
  /// [direction] Can be one of: asc or desc
  static Future<List<RepoEntity>> getStarredRepos({int page=1, String sort='created', String direction='desc'}) async {
    Map<String, dynamic> parameters = {'page': page, 'sort': sort, 'direction': direction};
    Response<List<dynamic>> response = await dioClient.dio.get("/user/starred", queryParameters: parameters);
    return response.data.map((item) => RepoEntity.fromJson(item)).toList();
  }
}