import 'package:dio/dio.dart';
import 'package:githao_v2/network/dio_client.dart';
import 'package:githao_v2/network/github_dio_error.dart';
import 'package:githao_v2/util/prefs_manager.dart';
import 'package:githao_v2/util/string_extension.dart';

class GithubInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.startsWith('/') && options.baseUrl == DioClient.BASE_URL) {
      final token = prefsManager.getToken();
      if (!token.isNullOrEmpty()) {
        options.headers['Authorization'] = 'token $token';
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final limit = int.tryParse(response.headers.value('x-ratelimit-limit') ?? '');
    final limitUsed = int.tryParse(response.headers.value('x-ratelimit-used') ?? '');
    final limitReset = int.tryParse(response.headers.value('x-ratelimit-reset') ?? '');
    if (limit != null && limitUsed != null && limitReset != null) {
      prefsManager.setRateLimit(limit);
      prefsManager.setRateLimitUsed(limitUsed);
      prefsManager.setRateLimitReset(limitReset * 1000);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.requestOptions.path.startsWith('/') &&
        err.requestOptions.baseUrl == DioClient.BASE_URL &&
        err.type == DioErrorType.response &&
        err.response?.data is Map<String, dynamic>) {
      return super.onError(GithubDioError(err), handler);
    }
    return super.onError(err, handler);
  }
}

