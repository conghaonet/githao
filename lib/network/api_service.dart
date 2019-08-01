import 'package:dio/dio.dart';
import 'package:githao/utils/shared_preferences.dart';

import 'bean/authorizations.dart';
import 'bean/authorizations_post.dart';
import 'bean/user.dart';
import 'dio_client.dart';

class ApiService {
  static Future<Authorizations> login(String credentialsBasic) async {
    dioClient.dio.options.headers["Authorization"] = credentialsBasic;
    Response<Map<String, dynamic>> response = await dioClient.dio.post("/authorizations", data: AuthorizationsPost().toJson());
    return Authorizations.fromJson(response.data);
  }
  static Future<User> getUser({String username}) async {
    SpUtil spUtil = await SpUtil.getInstance();
    if(spUtil.hasKey(SharedPreferencesKeys.gitHubAuthorizationBasic)) {
      dioClient.dio.options.headers["Authorization"] = spUtil.getString(SharedPreferencesKeys.gitHubAuthorizationBasic);
    }
    Response<Map<String, dynamic>> response = await dioClient.dio.get("/user");
    return User.fromJson(response.data);
  }
}