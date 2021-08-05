import 'package:dio/dio.dart';
import 'package:githao_v2/network/entity/repos/repo_entity.dart';
import 'package:githao_v2/network/entity/token_entity.dart';
import 'package:githao_v2/network/entity/token_request_model.dart';
import 'package:githao_v2/network/entity/user_entity.dart';
import 'package:githao_v2/util/const.dart';
import 'entity/git_hub_api_entity.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart' as http;

import 'dio_client.dart';

part 'git_hub_service.g.dart';

@RestApi(baseUrl: DioClient.BASE_URL)
abstract class GitHubService {
  factory GitHubService(Dio dio, {String baseUrl}) = _GitHubService;

  @GET("")
  Future<GitHubApiEntity> getApiMenu();

  @POST("https://github.com/login/oauth/access_token")
  @http.Headers(<String, dynamic>{"Accept" : "application/json"})
  Future<TokenEntity> accessToken(
      @Body() TokenRequestModel model,
      {@CancelRequest() CancelToken? cancelToken}
  );

  @GET("/user")
  Future<UserEntity> getUser();

  @GET("/users/{username}")
  Future<UserEntity> getOtherUser(@Path("username") String username);

  /// [since] A repository ID. Only return repositories with an ID greater than this ID.
  @GET('/repositories')
  Future<List<RepoEntity>> getRepos({@Query("since") int? sinceId});


}