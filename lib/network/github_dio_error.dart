import 'package:dio/dio.dart';

class GithubDioError extends DioError {
  GithubDioError(DioError dioError)
      : super(
            requestOptions: dioError.requestOptions,
            response: dioError.response,
            type: dioError.type,
            error: dioError.error);

}
