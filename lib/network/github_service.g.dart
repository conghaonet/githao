// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _GithubService implements GithubService {
  _GithubService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.github.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GithubApiEntity> getApiMenu({cacheable = false}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GithubApiEntity>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'cacheable': cacheable},
                extra: _extra)
            .compose(_dio.options, '',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GithubApiEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TokenEntity> accessToken(model, {cancelToken}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(model.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TokenEntity>(Options(
                method: 'POST',
                headers: <String, dynamic>{r'Accept': 'application/json'},
                extra: _extra)
            .compose(
                _dio.options, 'https://github.com/login/oauth/access_token',
                queryParameters: queryParameters,
                data: _data,
                cancelToken: cancelToken)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TokenEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserEntity> getUser({cacheable = false}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserEntity>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'cacheable': cacheable},
                extra: _extra)
            .compose(_dio.options, '/user',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserEntity> getOtherUser(username, {cacheable = false}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserEntity>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'cacheable': cacheable},
                extra: _extra)
            .compose(_dio.options, '/users/$username',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<RepoEntity>> getAllRepos({sinceId, cacheable = false}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'since': sinceId};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<RepoEntity>>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'cacheable': cacheable},
                extra: _extra)
            .compose(_dio.options, '/repositories',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => RepoEntity.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<RepoEntity>> getRepos(username,
      {queries, page = 1, cacheable = false}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    queryParameters.addAll(queries?.toJson() ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<RepoEntity>>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'cacheable': cacheable},
                extra: _extra)
            .compose(_dio.options, '/users/$username/repos',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => RepoEntity.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<RepoEntity>> getMyRepos(
      {queries, page = 1, cacheable = false}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    queryParameters.addAll(queries?.toJson() ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<RepoEntity>>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'cacheable': cacheable},
                extra: _extra)
            .compose(_dio.options, '/user/repos',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => RepoEntity.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<RepoEntity>> getOrgRepos(org,
      {queries, page = 1, cacheable = false}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    queryParameters.addAll(queries?.toJson() ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<RepoEntity>>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'cacheable': cacheable},
                extra: _extra)
            .compose(_dio.options, '/orgs/$org/repos',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => RepoEntity.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<RepoEntity> getRepo(
      {required owner, required repoName, cacheable = false}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RepoEntity>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'cacheable': cacheable},
                extra: _extra)
            .compose(_dio.options, '/repos/$owner/$repoName',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RepoEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<OrgEntity>> getMyOrgs({page = 1, cacheable = false}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<OrgEntity>>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'cacheable': cacheable},
                extra: _extra)
            .compose(_dio.options, '/user/orgs',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => OrgEntity.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<HttpResponse<dynamic>> getStarredRepo(owner, repo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/user/starred/$owner/$repo',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> starRepo(owner, repo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'PUT', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/user/starred/$owner/$repo',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> delStarredRepo(owner, repo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'DELETE', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/user/starred/$owner/$repo',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<RepoSubscriptionEntity> getRepoSubscription(owner, repo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RepoSubscriptionEntity>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/repos/$owner/$repo/subscription',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RepoSubscriptionEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RepoSubscriptionEntity> setRepoSubscription(owner, repo,
      {required queries}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(queries.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RepoSubscriptionEntity>(
            Options(method: 'PUT', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/repos/$owner/$repo/subscription',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RepoSubscriptionEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HttpResponse<dynamic>> delRepoSubscription(owner, repo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'DELETE', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/repos/$owner/$repo/subscription',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<RepoContentEntity> getRepoContent(owner, repo, path, branch) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ref': branch};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RepoContentEntity>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/repos/$owner/$repo/contents/$path',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RepoContentEntity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HttpResponse<dynamic>> getRepoContentHtml(
      owner, repo, path, branch) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ref': branch};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Accept': 'application/vnd.github.v3.html'
                },
                extra: _extra)
            .compose(_dio.options, '/repos/$owner/$repo/contents/$path',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
