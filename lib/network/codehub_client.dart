import 'dart:io';

import 'package:dio/dio.dart';
import 'package:githao/utils/shared_preferences.dart';

/// http://trending.codehub-app.com/v2/trending?since=weekly&language=dart
class CodehubClient {
  static const BASE_API = "http://trending.codehub-app.com/v2";
  static BaseOptions baseOptions = BaseOptions(
    baseUrl: BASE_API,
    connectTimeout: 30000,
    receiveTimeout: 20000,
  );

  static final CodehubClient _codehubClient = CodehubClient._internal();
  Dio _dio = new Dio(baseOptions);
  Dio get dio => _dio;

  factory CodehubClient() {
    return _codehubClient;
  }
  CodehubClient._internal() {

    //TODO：设置代理
    setProxy("192.168.2.100", 8888);

    //设置拦截器
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(Options options) async {
          //添加验证头信息
          if(!options.headers.containsKey('Authorization') || (options.headers['Authorization'] as String).isEmpty) {
            SpUtil spUtil = await SpUtil.getInstance();
            if(spUtil.hasKey(SharedPreferencesKeys.gitHubAuthorizationBasic)) {
              String value = spUtil.getString(SharedPreferencesKeys.gitHubAuthorizationBasic);
              if(value != null && value.isNotEmpty) {
                options.headers['Authorization'] = value;
              }
            }
          }
          return options;
        }
    ));
//    _dio.interceptors.add(LogInterceptor(responseBody: false)); //开启请求日志
  }

  /// 设置代理
  void setProxy(String proxyServer, int port) {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.findProxy = (uri) {
        return "PROXY $proxyServer:$port";
      };
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    };
  }
}

CodehubClient codehubClient = CodehubClient();