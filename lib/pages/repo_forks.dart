import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/pages/profile.dart';
import 'package:githao/pages/repo_home.dart';
import 'package:githao/routes/profile_page_args.dart';
import 'package:githao/widgets/base_list.dart';

class RepoForksPage extends BaseListWidget {
  static const ROUTE_NAME = "/repo_forks";
  final String repoName;

  RepoForksPage(this.repoName, {Key key}): super(key: key);

  @override
  _RepoForksPageState createState() => _RepoForksPageState();
}

class _RepoForksPageState extends BaseListWidgetState<RepoForksPage, RepoEntity> {
  @override
  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            S.current.forks,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.repoName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Future<List<RepoEntity>> getDatum(int expectationPage) {
    return ApiService.getRepoForks(widget.repoName, page: expectationPage);
  }

  @override
  Widget buildItem(RepoEntity entity, int index) {
    String _heroTag = entity.fullName;
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RepoHomePage.ROUTE_NAME, arguments: entity);
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 80,
                ),
                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Hero(
                      //默认情况下，当在 iOS 上按后退按钮时，hero 动画会有效果，但它们在手势滑动时并没有。
                      //要解决此问题，只需在两个 Hero 组件上将 transitionOnUserGestures 设置为 true 即可
                      transitionOnUserGestures: true,
                      tag: _heroTag,
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(entity.owner.avatarUrl),
                        backgroundColor: Colors.black12,
                      ),
                    ),
                    SizedBox(width: 24,),
                    Expanded(
                      child: Text(
                        entity.fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}