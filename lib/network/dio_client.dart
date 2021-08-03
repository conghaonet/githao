import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:githao_v2/network/git_hub_interceptors.dart';

class DioClient {
  static const BASE_API = "https://api.github.com";
  static const API_VERSION = "application/vnd.github.v3+json";
  static const DEFAULT_CHARSET = "UTF-8";
  static BaseOptions baseOptions = BaseOptions(
    baseUrl: BASE_API,
    connectTimeout: 30000,
    receiveTimeout: 20000,
    headers:{"Accept": 'application/json'},
  );
  Dio _dio = new Dio(baseOptions);
  Dio get dio => _dio;

  factory DioClient() => _dioClient;
  static final DioClient _dioClient = DioClient._internal();
  DioClient._internal() {
    // setProxy("192.168.2.100", 8888);
//    _dio.interceptors.add(LogInterceptor(responseBody: false));
    _dio.interceptors.add(GitHubInterceptors());
  }

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