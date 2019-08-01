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

  static const CLIENT_ID  = "c868cf1dc9c48103bb55";
  static const CLIENT_SECRET  = "b341fe1eb154f1d78b4f8f58288106d95bce3bf0";
  static const APPLICATION_NAME = "HaoGitHub";
  static const CALLBACK_URL = "https://github.com/conghaonet/HaoGitHub/callback";

  static final DioClient _dioClient = DioClient._internal();
  Dio _dio = new Dio();
  Dio get dio => _dio;

  factory DioClient() {
    return _dioClient;
  }
  DioClient._internal() {
    _dio.options..receiveTimeout = 10000
    ..connectTimeout = 15000
    ..baseUrl = BASE_API
    ..headers["api-version"] = API_VERSION
    ..headers["Content-Type"] = CONTENT_TYPE;

//    setAuthHeader();

    //设置代理
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.findProxy = (uri) {
        return "PROXY 192.168.2.100:8888";
      };
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    };

  }

  setAuthHeader() async {
    SpUtil spUtil = await SpUtil.getInstance();
    if(spUtil.hasKey(SharedPreferencesKeys.gitHubAuthorizationBasic)) {
      _dio.options.headers["Authorization"] = spUtil.getString(SharedPreferencesKeys.gitHubAuthorizationBasic);
    }
  }
}

DioClient dioClient = DioClient();