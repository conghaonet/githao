import 'package:dio/dio.dart';
import 'package:githao/network/entity/repos/repo_entity.dart';
import 'package:githao/network/entity/token_entity.dart';
import 'package:githao/network/entity/token_request_model.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'entity/github_api_entity.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart' as http;

import 'dio_client.dart';

part 'github_service.g.dart';

@RestApi(baseUrl: DioClient.BASE_URL)
abstract class GithubService {
  factory GithubService(Dio dio, {String baseUrl}) = _GithubService;

  /// https://api.github.com
  @GET("")
  Future<GithubApiEntity> getApiMenu();

  /// https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps
  @POST("https://github.com/login/oauth/access_token")
  @http.Headers(<String, dynamic>{"Accept" : "application/json"})
  Future<TokenEntity> accessToken(
      @Body() TokenRequestModel model,
      {@CancelRequest() CancelToken? cancelToken}
  );

  /// https://docs.github.com/en/rest/reference/users#get-the-authenticated-user
  @GET("/user")
  Future<UserEntity> getUser();

  /// https://docs.github.com/en/rest/reference/users#get-a-user
  @GET("/users/{username}")
  Future<UserEntity> getOtherUser(@Path("username") String username);

  /// https://docs.github.com/en/rest/reference/repos#list-public-repositories
  /// [since] A repository ID. Only return repositories with an ID greater than this ID.
  @GET('/repositories')
  Future<List<RepoEntity>> getRepos({@Query("since") int? sinceId});

  /// https://docs.github.com/cn/rest/reference/repos#list-repositories-for-the-authenticated-user
  @GET('/user/repos')
  Future<List<RepoEntity>> getMyRepos();

}

final GithubService githubService = GithubService(dioClient.dio);