import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:githao/network/cache_interceptor.dart';
import 'package:githao/network/github_interceptor.dart';

class DioClient {
  static const BASE_URL = "https://api.github.com";
  static const API_VERSION = "application/vnd.github.v3+json";
  static const API_PREVIEW_VERSION = 'application/vnd.github.nebula-preview+json';
  static const DEFAULT_CHARSET = "UTF-8";
  static const EXTRA_CACHEABLE = 'cacheable';
  static BaseOptions baseOptions = BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: 30000,
    receiveTimeout: 20000,
    headers:{"Accept": API_PREVIEW_VERSION},
  );
  Dio _dio = new Dio(baseOptions);
  Dio get dio => _dio;

  factory DioClient() => _dioClient;
  static final DioClient _dioClient = DioClient._internal();
  DioClient._internal() {
    // setProxy("127.0.0.1", 7890);
    _dio.interceptors.add(GithubInterceptor());
    _dio.interceptors.add(CacheInterceptor());
    _dio.interceptors.add(LogInterceptor(responseBody: true));
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

final DioClient dioClient = DioClient();