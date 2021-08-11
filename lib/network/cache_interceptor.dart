import 'package:dio/dio.dart';
import 'package:githao/network/dio_client.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

class CacheInterceptor extends Interceptor {
  final _cache = <Uri, Response>{};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // retrofit 不能动态设置extra，这里先赋值给header，拦截后再赋值给extra。
    options.extra[DioClient.EXTRA_CACHEABLE] = options.headers[DioClient.EXTRA_CACHEABLE];
    var response = _cache[options.uri];
    if(options.method == HttpMethod.GET &&
        response != null &&
        options.extra[DioClient.EXTRA_CACHEABLE] == true) {
      return handler.resolve(response);
    } else {
      return super.onRequest(options, handler);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.requestOptions.method == HttpMethod.GET) {
      _cache[response.requestOptions.uri] = response;
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('onError: $err');
    return super.onError(err, handler);
  }
}
