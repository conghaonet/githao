import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:githao/network/entity/authorization_entity.dart';
import 'package:githao/network/entity/authorization_post.dart';
import 'package:githao/network/entity/commit_detail_entity.dart';
import 'package:githao/network/entity/issue_entity.dart';
import 'package:githao/network/entity/search_entity.dart';
import 'codehub_client.dart';
import 'entity/commit_entity.dart';
import 'entity/event_entity.dart';
import 'entity/repo_content_entity.dart';
import 'entity/repo_entity.dart';
import 'entity/user_entity.dart';
import 'dio_client.dart';

class ApiService {
  static Future<AuthorizationEntity> login(String credentialsBasic) async {
    Options options = Options(headers: {"Authorization": credentialsBasic});
    Response<Map<String, dynamic>> response = await dioClient.dio.post("/authorizations", data: AuthorizationPost().toJson(), options: options);
    return AuthorizationEntity.fromJson(response.data);
  }

  static Future<UserEntity> getUser(String username) async {
    Response<Map<String, dynamic>> response = await dioClient.dio.get("/users/$username");
    return UserEntity.fromJson(response.data);
  }

  static Future<UserEntity> getAuthenticatedUser() async {
    Response<Map<String, dynamic>> response = await dioClient.dio.get("/user");
    return UserEntity.fromJson(response.data);
  }

  static Future<RepoEntity> getRepo(String repoName) async {
    Response<Map<String, dynamic>> response = await dioClient.dio.get("/repos/$repoName");
    return RepoEntity.fromJson(response.data);
  }

  /// [login] GitHub显示的用户名
  /// [page] 取值从1开始，表示请求第几页，每页返回30笔数据
  /// [type] Can be one of: all, owner, public, private, member
  /// [sort] Can be one of: created, updated, pushed, full_name
  /// [direction] Can be one of: asc or desc
  static Future<List<RepoEntity>> getUserRepos(String login, {int page=1, String type='all', String sort='full_name', String direction='asc'}) async {
    Map<String, dynamic> parameters = {'page': page, 'type': type, 'sort': sort, 'direction': direction};
    Response<List<dynamic>> response = await dioClient.dio.get("/users/$login/repos", queryParameters: parameters);
    return response.data.map((item) => RepoEntity.fromJson(item)).toList();
  }

  static Future<List<RepoEntity>> getOrgRepos(String org, {int page=1, String type='all', String sort='full_name', String direction='asc'}) async {
    Map<String, dynamic> parameters = {'page': page, 'type': type, 'sort': sort, 'direction': direction};
    Response<List<dynamic>> response = await dioClient.dio.get("/orgs/$org/repos", queryParameters: parameters);
    return response.data.map((item) => RepoEntity.fromJson(item)).toList();
  }

  /// [login] GitHub显示的用户名
  /// [sort] One of created (when the repository was starred) or updated (when it was last pushed to). Default: created
  /// [direction] Can be one of: asc or desc
  static Future<List<RepoEntity>> getUserStarredRepos(String login, {int page=1, String sort='created', String direction='desc'}) async {
    Map<String, dynamic> parameters = {'page': page, 'sort': sort, 'direction': direction};
    Response<List<dynamic>> response = await dioClient.dio.get("/users/$login/starred", queryParameters: parameters);
    return response.data.map((item) => RepoEntity.fromJson(item)).toList();
  }

  static Future<List<EventEntity>> getEvents(String login, {String repoName, int page=1}) async {
    Response<List<dynamic>> response;
    if(repoName == null || repoName.isEmpty) {
      response = await dioClient.dio.get("/users/$login/events?page=$page");
    } else {
      response = await dioClient.dio.get("/repos/$login/$repoName/events?page=$page");
    }
    return response.data.map((item) => EventEntity.fromJson(item)).toList();
  }

  static Future<String> getRepoReadme(String owner, String repo) async {
    Options options = Options(headers: {"Accept": "application/vnd.github.VERSION.html"});
    Response<String> response = await dioClient.dio.get("/repos/$owner/$repo/readme", options: options);
    return response.data;
  }

  static Future<List<RepoContentEntity>> getRepoContents(String owner, String repo, String branch, {String path = ''}) async {
    Map<String, dynamic> parameters = {'ref': branch};
    Response<List<dynamic>> response = await dioClient.dio.get("/repos/$owner/$repo/contents/$path", queryParameters: parameters);
    return response.data.map((item) => RepoContentEntity.fromJson(item)).toList();
  }

  static Future<String> getRepoContentRaw(String owner, String repo, String branch, String path) async {
    Options options = Options(headers: {"Accept": "application/vnd.github.VERSION.raw"});
    Map<String, dynamic> parameters = {'ref': branch};
    Response<String> response = await dioClient.dio.get("/repos/$owner/$repo/contents/$path", queryParameters: parameters, options: options);
    return response.data;
  }

  static Future<String> getRepoContentHtml(String owner, String repo, String branch, String path) async {
    Options options = Options(headers: {"Accept": "application/vnd.github.VERSION.html"});
    Map<String, dynamic> parameters = {'ref': branch};
    Response<String> response = await dioClient.dio.get("/repos/$owner/$repo/contents/$path", queryParameters: parameters, options: options);
    return response.data;
  }

  static Future<List<CommitEntity>> getRepoCommits(String owner, String repo, String branch, {int page=1}) async {
    Map<String, dynamic> parameters = {'sha': branch, 'page': page};
    Response<List<dynamic>> response = await dioClient.dio.get("/repos/$owner/$repo/commits", queryParameters: parameters);
    return response.data.map((item) => CommitEntity.fromJson(item)).toList();
  }
  static Future<CommitDetailEntity> getCommitDetail(String owner, String repo, String sha) async {
    Response<Map<String, dynamic>> response = await dioClient.dio.get("/repos/$owner/$repo/commits/$sha");
    return CommitDetailEntity.fromJson(response.data);
  }

  /// [filter] : assigned(Default), created, mentioned, subscribed, all
  /// [state] : open(Default), closed, all
  /// [labels] : A list of comma separated label names. Example: bug,ui,@high
  /// [sort] : created(Default), updated, comments
  /// [direction] : asc or desc, Default: desc
  /// [since] Only issues updated at or after this time are returned. This is a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ.
  static Future<List<IssueEntity>> getIssues({String filter='assigned', String state='open',
    List<String> labels, String sort='created', String direction='desc', String since='', int page = 1}) async {
    Map<String, dynamic> parameters = {'filter': filter, 'state': state, 'labels': labels ?? '', 'sort': sort,
      'direction': direction, 'since': since, 'page': page};
    Response<List<dynamic>> response = await dioClient.dio.get("/issues", queryParameters: parameters);
    return response.data.map((item) => IssueEntity.fromJson(item)).toList();
  }

  /// [state] Indicates the state of the issues to return. Can be either open, closed, or all. Default: open
  /// [sort] created, updated
  /// [order] Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc).
  ///         This parameter is ignored unless you provide sort. Default: desc
  static Future<List<IssueEntity>> getRepoIssues({String repoName, String state='open', String sort='updated', String order='desc', int page = 1}) async {
    Map<String, dynamic> parameters = {'state': state, 'sort': sort, 'order': order, 'page': page};
    Response<List<dynamic>> response = await dioClient.dio.get("/repos/$repoName/issues", queryParameters: parameters);
    return response.data.map((item) => IssueEntity.fromJson(item)).toList();
  }

  static Future<List<UserEntity>> getRepoStargazers(String repoFullName, {int page=1}) async {
    Map<String, dynamic> parameters = {'page': page};
    Response<List<dynamic>> response = await dioClient.dio.get("/repos/$repoFullName/stargazers", queryParameters: parameters);
    return response.data.map((item) => UserEntity.fromJson(item)).toList();
  }

  static Future<List<RepoEntity>> getRepoForks(String repoFullName, {int page=1}) async {
    Map<String, dynamic> parameters = {'page': page};
    Response<List<dynamic>> response = await dioClient.dio.get("/repos/$repoFullName/forks", queryParameters: parameters);
    return response.data.map((item) => RepoEntity.fromJson(item)).toList();
  }

  static Future<List<UserEntity>> getRepoWatchers(String repoFullName, {int page=1}) async {
    Map<String, dynamic> parameters = {'page': page};
    Response<List<dynamic>> response = await dioClient.dio.get("/repos/$repoFullName/subscribers", queryParameters: parameters);
    return response.data.map((item) => UserEntity.fromJson(item)).toList();
  }

  static Future<List<UserEntity>> getUserFollowers(String login, {int page=1}) async {
    Map<String, dynamic> parameters = {'page': page};
    Response<List<dynamic>> response = await dioClient.dio.get("/users/$login/followers", queryParameters: parameters);
    return response.data.map((item) => UserEntity.fromJson(item)).toList();
  }

  static Future<List<UserEntity>> getUserFollowing(String login, {int page=1}) async {
    Map<String, dynamic> parameters = {'page': page};
    Response<List<dynamic>> response = await dioClient.dio.get("/users/$login/following", queryParameters: parameters);
    return response.data.map((item) => UserEntity.fromJson(item)).toList();
  }

  /// [state] +state:open, +state:closed, +state:open+state:closed(ALL)
  /// [sort] created, updated
  /// [order] Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc).
  ///         This parameter is ignored unless you provide sort. Default: desc
  static Future<List<IssueEntity>> searchIssues({String login, String state, String sort='updated', String order='desc', int page = 1}) async {
    String q = 'involves:$login$state';
    Map<String, dynamic> parameters = {'sort': sort, 'order': order, 'page': page};
    Response<Map<String, dynamic>> response = await dioClient.dio.get("/search/issues?q=$q", queryParameters: parameters);
    var searchEntity = SearchEntity.fromJson(response.data);
    if(searchEntity != null && searchEntity.items != null && searchEntity.items.isNotEmpty) {
      return searchEntity.items.map((item) => IssueEntity.fromJson(item)).toList();
    } else {
      return List<IssueEntity>();
    }
  }

  /// [keyword] search keyword
  /// [sort] created, updated
  /// [order] Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc).
  ///         This parameter is ignored unless you provide sort. Default: desc
  static Future<List<RepoEntity>> searchRepos({String keyword, String sort='', String order='desc', int page = 1}) async {
    Map<String, dynamic> parameters = {'q': keyword, 'sort': sort, 'order': order, 'page': page};
    Response<Map<String, dynamic>> response = await dioClient.dio.get("/search/repositories", queryParameters: parameters);
    var searchEntity = SearchEntity.fromJson(response.data);
    if(searchEntity != null && searchEntity.items != null && searchEntity.items.isNotEmpty) {
      return searchEntity.items.map((item) => RepoEntity.fromJson(item)).toList();
    } else {
      return List<RepoEntity>();
    }
  }

  /// [keyword] search keyword
  /// [sort] created, updated
  /// [order] Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc).
  ///         This parameter is ignored unless you provide sort. Default: desc
  static Future<List<UserEntity>> searchUsers({String keyword, String sort='', String order='desc', int page = 1}) async {
    Map<String, dynamic> parameters = {'q': keyword, 'sort': sort, 'order': order, 'page': page};
    Response<Map<String, dynamic>> response = await dioClient.dio.get("/search/users", queryParameters: parameters);
    var searchEntity = SearchEntity.fromJson(response.data);
    if(searchEntity != null && searchEntity.items != null && searchEntity.items.isNotEmpty) {
      return searchEntity.items.map((item) => UserEntity.fromJson(item)).toList();
    } else {
      return List<UserEntity>();
    }
  }

  ///github不提供trending api，这里调用第三方API实现
  static Future<List<RepoEntity>> getTrending({String since='daily', String language=''}) async {
    Map<String, dynamic> parameters = {'since': since, 'language': language};
    Response<List<dynamic>> response = await codehubClient.dio.get("/trending", queryParameters: parameters);
    return response.data.map((item) => RepoEntity.fromJson(item)).toList();
  }

  /// 检查当前登录用户是否对该版本库评星
  /// 已评星: statusCode=204, 未评星：statusCode=404
  static Future<bool> getStarredRepo(String repoFullName) async {
    try {
      Response<String> response = await dioClient.dio.get("/user/starred/$repoFullName");
      if(response.statusCode == 204) return true;
      else return false;
    } catch (e) {
      return false;
    }
  }

  /// Star or Unstar a repository
  /// 已评星: statusCode=204, 未评星：statusCode=404
  static Future<bool> startOrUnstarRepo(String repoFullName, bool isStar) async {
    bool actionResult = false;
    try {
      Response<String> response;
      if(isStar) {
        response= await dioClient.dio.put("/user/starred/$repoFullName");
      } else {
        response= await dioClient.dio.delete("/user/starred/$repoFullName");
      }
      if(response.statusCode == 204) actionResult = true;
    } catch(e) {
    }
    return actionResult;
  }
}