
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/entity/repos/repos_queries_entity.dart';
import 'package:githao/network/github_service.dart';
import 'package:githao/util/prefs_manager.dart';
import 'package:githao/util/string_extension.dart';
import 'package:githao/network/entity/repos/repo_entity.dart';

class HomeRepos extends StatefulWidget {
  const HomeRepos({Key? key}) : super(key: key);

  @override
  _HomeReposState createState() => _HomeReposState();
}

class _HomeReposState extends State<HomeRepos> {
  final List<RepoEntity> _repos = [];
  @override
  void initState() {
    super.initState();
    _initData();
  }
  void _initData() async {
    final result = await githubService.getRepos(
      prefsManager.getUser()!.login!,
      queries: ReposQueriesEntity().toJson(),
    );
    _repos.addAll(result);
    if(mounted) {
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: _repos.length,
        itemBuilder: (context, index) {
          return _buildItem(_repos[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(height: 0.5, thickness: 0.5,);
        },
      ),
    );
  }

  Widget _buildItem(RepoEntity repoEntity) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24.0,
                backgroundImage: CachedNetworkImageProvider(repoEntity.owner!.avatarUrl!),
              ),
              SizedBox(width: 8,),
              Text(repoEntity.name!),
              Text(repoEntity.organization?.login ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}
