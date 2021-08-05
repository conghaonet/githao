import 'package:dio/dio.dart';

class GitHubDioError extends DioError {
  GitHubDioError(DioError dioError)
      : super(
            requestOptions: dioError.requestOptions,
            response: dioError.response,
            type: dioError.type,
            error: dioError.error);

}
