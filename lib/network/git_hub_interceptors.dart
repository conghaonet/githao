import 'package:dio/dio.dart';
import 'package:githao_v2/network/dio_client.dart';
import 'package:githao_v2/util/prefs_manager.dart';
import 'package:githao_v2/util/string_extension.dart';

class GitHubInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if(options.path.startsWith('/') && options.baseUrl == DioClient.BASE_URL) {
      final token = prefsManager.getToken();
      if(!token.isNullOrEmpty()) {
        options.headers['Authorization'] = 'token $token';
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}] => MESSAGE: ${err.message}');
    return super.onError(err, handler);
  }
}