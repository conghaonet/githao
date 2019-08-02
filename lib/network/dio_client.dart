import 'dart:io';

import 'package:dio/dio.dart';
import 'package:githao/utils/shared_preferences.dart';

class DioClient {
  static const BASE_API = "https://api.github.com";
  static const API_VERSION = "application/vnd.github.v3+json";
  static const REQUEST_MEDIA_TYPE = "application";
  static const REQUEST_MEDIA_SUB_TYPE = "json";
  static const CONTENT_TYPE = "$REQUEST_MEDIA_TYPE/$REQUEST_MEDIA_SUB_TYPE";
  static const DEFAULT_CHARSET = "UTF-8";
  static BaseOptions baseOptions = BaseOptions(
    baseUrl: BASE_API,
    connectTimeout: 15000,
    receiveTimeout: 10000,
    headers:{"Accept": API_VERSION, "Content-Type": CONTENT_TYPE},
  );

  static final DioClient _dioClient = DioClient._internal();
  Dio _dio = new Dio(baseOptions);
  Dio get dio => _dio;

  factory DioClient() {
    return _dioClient;
  }
  DioClient._internal() {

    //设置代理
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

DioClient dioClient = DioClient();