import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:githao/network/entity/repo/repo_entity.dart';

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
        title: Row(
          children: [
            Flexible(
              child: Text(repoEntity.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if(repoEntity.private == true)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: ImageIcon(Svg('assets/github/lock-16.svg',), size: 16,),
              ),
            if(repoEntity.fork == true)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: ImageIcon(Svg('assets/github/repo-forked-16.svg',), size: 16,),
              ),
          ],
        ),
        subtitle: Text(repoEntity.owner!.login!,),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
