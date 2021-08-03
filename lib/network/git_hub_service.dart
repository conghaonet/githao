import 'package:dio/dio.dart';
import '/entity/git_hub_api_entity.dart';
import 'package:retrofit/retrofit.dart';

import 'dio_client.dart';

part 'git_hub_service.g.dart';

@RestApi(baseUrl: DioClient.BASE_API)
abstract class GitHubService {
  factory GitHubService(Dio dio, {String baseUrl}) = _GitHubService;

  @GET("")
  Future<GitHubApiEntity> getApiMenu();
}