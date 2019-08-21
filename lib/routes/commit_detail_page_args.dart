import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/network/entity/user_entity.dart';

class CommitDetailPageArgs {
  final UserEntity committer;
  final RepoEntity repoEntity;
  final String sha;

  CommitDetailPageArgs({this.committer, this.repoEntity, this.sha,});

}