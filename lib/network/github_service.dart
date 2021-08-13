import 'package:dio/dio.dart';
import 'package:githao/network/entity/org/org_entity.dart';
import 'package:githao/network/entity/repo/repo_entity.dart';
import 'package:githao/network/entity/repo/repos_queries_entity.dart';
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
  /// [cacheable] false: 不实用缓存数据；true：使用缓存数据
  @GET("")
  Future<GithubApiEntity> getApiMenu({
    @Header(DioClient.EXTRA_CACHEABLE) bool cacheable = false,
  });

  /// https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps
  /// [cacheable] false: 不实用缓存数据；true：使用缓存数据
  @POST("https://github.com/login/oauth/access_token")
  @http.Headers(<String, dynamic>{"Accept" : "application/json"})
  Future<TokenEntity> accessToken(
      @Body() TokenRequestModel model,
      {@CancelRequest() CancelToken? cancelToken}
  );

  /// https://docs.github.com/en/rest/reference/users#get-the-authenticated-user
  /// [cacheable] false: 不实用缓存数据；true：使用缓存数据
  @GET("/user")
  Future<UserEntity> getUser({
    @Header(DioClient.EXTRA_CACHEABLE) bool cacheable = false,
  });

  /// https://docs.github.com/en/rest/reference/users#get-a-user
  /// [cacheable] false: 不实用缓存数据；true：使用缓存数据
  @GET("/users/{username}")
  Future<UserEntity> getOtherUser(@Path("username") String username, {
    @Header(DioClient.EXTRA_CACHEABLE) bool cacheable = false,
  });

  /// https://docs.github.com/en/rest/reference/repos#list-public-repositories
  /// [since] A repository ID. Only return repositories with an ID greater than this ID.
  /// [cacheable] false: 不实用缓存数据；true：使用缓存数据
  @GET('/repositories')
  Future<List<RepoEntity>> getAllRepos({
    @Query("since") int? sinceId,
    @Header(DioClient.EXTRA_CACHEABLE) bool cacheable = false,
  });

  /// https://docs.github.com/cn/rest/reference/repos#list-repositories-for-a-user
  /// [cacheable] false: 不实用缓存数据；true：使用缓存数据
  @GET('/users/{username}/repos')
  Future<List<RepoEntity>> getRepos(@Path('username') String username, {
    @Queries() ReposQueriesEntity? queries,
    @Header(DioClient.EXTRA_CACHEABLE) bool? cacheable = false,
  });

  /// https://docs.github.com/cn/rest/reference/repos#list-repositories-for-the-authenticated-user
  /// [cacheable] false: 不实用缓存数据；true：使用缓存数据
  @GET('/user/repos')
  Future<List<RepoEntity>> getMyRepos({
    @Queries() ReposQueriesEntity? queries,
    @Header(DioClient.EXTRA_CACHEABLE) bool? cacheable = false,
  });

  /// https://docs.github.com/cn/rest/reference/repos#list-organization-repositories
  /// [cacheable] false: 不实用缓存数据；true：使用缓存数据
  @GET('/orgs/{org}/repos')
  Future<List<RepoEntity>> getOrgRepos(@Path('org') String org, {
    @Queries() ReposQueriesEntity? queries,
    @Header(DioClient.EXTRA_CACHEABLE) bool? cacheable = false,
  });

  /// https://docs.github.com/en/rest/reference/orgs#list-organizations-for-the-authenticated-user
  /// [cacheable] false: 不实用缓存数据；true：使用缓存数据
  @GET('/user/orgs')
  Future<List<OrgEntity>> getMyOrgs({
    @Query("page") int page = 1,
    @Header(DioClient.EXTRA_CACHEABLE) bool? cacheable = false,
  });

}

final GithubService githubService = GithubService(dioClient.dio);