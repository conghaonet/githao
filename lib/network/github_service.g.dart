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
      {queries, cacheable = false}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
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
