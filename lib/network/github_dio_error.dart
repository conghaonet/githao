import 'package:dio/dio.dart';

class GithubDioError extends DioError {
  GithubDioError(DioError dioError)
      : super(
            requestOptions: dioError.requestOptions,
            response: dioError.response,
            type: dioError.type,
            error: dioError.error);

  // "message" -> "Requires authentication"
  String? get githubMessage =>(this.response?.data as Map<String, dynamic>?)?['message'];

  String? get githubDocumentationUrl {
    //"documentation_url" -> "https://docs.github.com/rest/reference/users#get-the-authenticated-user"
    return (this.response?.data as Map<String, dynamic>?)?['documentation_url'];
  }
}
