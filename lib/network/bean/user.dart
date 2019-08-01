import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'user.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class User {
  String login;
  int id;
  String node_id;
  String avatar_url;
  String gravatar_id;
  String url;
  String html_url;
  String followers_url;
  String following_url;
  String gists_url;
  String starred_url;
  String subscriptions_url;
  String organizations_url;
  String repos_url;
  String events_url;
  String received_events_url;
  String type;
  bool site_admin;
  String name;
  String company;
  String blog;
  String location;
  String email;
  String hireable;
  String bio;
  int public_repos;
  int public_gists;
  int followers;
  int following;
  String created_at;
  String updated_at;
  int private_gists;
  int total_private_repos;
  int owned_private_repos;
  int disk_usage;
  int collaborators;
  bool two_factor_authentication;
  UserPlan plan;
  User({this.login, this.id, this.node_id, this.avatar_url, this.gravatar_id, this.url, this.html_url, this.followers_url, this.following_url,
    this.gists_url, this.starred_url, this.subscriptions_url, this.organizations_url, this.repos_url, this.events_url, this.received_events_url,
    this.type, this.site_admin, this.name, this.company, this.blog, this.location, this.email, this.hireable, this.bio, this.public_repos,
    this.public_gists, this.followers, this.following, this.created_at, this.updated_at, this.private_gists, this.total_private_repos,
    this.owned_private_repos, this.disk_usage, this.collaborators, this.two_factor_authentication, this.plan});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}

@JsonSerializable()
class UserPlan {
  String name;
  int space;
  int collaborators;
  int private_repos;
  UserPlan({this.name, this.space, this.collaborators, this.private_repos});

  factory UserPlan.fromJson(Map<String, dynamic> json) => _$UserPlanFromJson(json);
  Map<String, dynamic> toJson() => _$UserPlanToJson(this);

}