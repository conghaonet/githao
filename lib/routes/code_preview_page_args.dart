import 'package:githao/network/entity/repo_entity.dart';

class CodePreviewPageArgs {
  final String contentPath;
  final RepoEntity repoEntity;
  final String branch;
  CodePreviewPageArgs(this.contentPath, this.repoEntity, this.branch);
}