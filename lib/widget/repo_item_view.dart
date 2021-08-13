import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/entity/repos/repo_entity.dart';

class RepoItemView extends StatelessWidget {
  final RepoEntity repoEntity;
  const RepoItemView(this.repoEntity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(repoEntity.owner!.avatarUrl!),
        ),
        title: Text(repoEntity.name!,),
        subtitle: Text(repoEntity.owner!.login!,),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
