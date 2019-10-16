import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/pages/profile_page.dart';
import 'package:githao/pages/repo_home_page.dart';
import 'package:githao/resources/custom_icons_icons.dart';
import 'package:githao/resources/lang_colors.dart';
import 'package:githao/routes/profile_page_args.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/my_visibility.dart';

class RepoItem extends StatelessWidget {
  final RepoEntity repo;
  final String tag;
  RepoItem(this.repo, {this.tag, Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    String avatarHeroTag = 'repoitem_${this.tag ?? ''}_${this.repo.fullName}';
    return Card(
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: (){
          Navigator.pushNamed(context, RepoHomePage.ROUTE_NAME, arguments: this.repo.fullName);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context, ProfilePage.ROUTE_NAME,
                    arguments: ProfilePageArgs(
                        userEntity: this.repo.owner,
                        heroTag: avatarHeroTag
                    ),
                  );
                },
                child: Hero(
                  //默认情况下，当在 iOS 上按后退按钮时，hero 动画会有效果，但它们在手势滑动时并没有。
                  //要解决此问题，只需在两个 Hero 组件上将 transitionOnUserGestures 设置为 true 即可
                  transitionOnUserGestures: true,
                  tag: avatarHeroTag,
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(this.repo.owner.avatarUrl),
                    backgroundColor: Colors.black12,
                  ),
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Offstage(
                          offstage: !this.repo.fork,
                          child: Icon(CustomIcons.fork, color: Theme.of(context).primaryColor, size: 18,),
                        ),
                        Expanded(
                          child: Text(this.repo.name,
                            maxLines: 2,
                            style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4,),
                    MyVisibility(
                      flag: this.repo.description == null ? MyVisibilityFlag.gone : MyVisibilityFlag.visible,
                      child: Text(this.repo.description ?? '',
                        maxLines: 4,
                        softWrap: true,
                        style: TextStyle(),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: <Widget>[
                        _getOwner(context, this.repo.owner.login),
                        _getIssues(context, this.repo.openIssues),
                        //抓包发现watchers和stargazersCount数值完全一样，应该是GitHub的bug
//                      _getWatchers(this.repo.watchers),
                        _getStargazersCount(context, this.repo.stargazersCount),
                        _getForks(context, this.repo.forks),
                        _getLanguage(context, this.repo.language),
                        _getPushedTime(context, this.repo.pushedAt),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getOwner(BuildContext context, String owner) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.account_circle, color: Theme.of(context).primaryColor, size: 18,),
        SizedBox(width: 2,),
        Text(owner),
      ],
    );
  }
  Widget _getIssues(BuildContext context, int issues) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.info, color: Theme.of(context).primaryColor, size: 18,),
        SizedBox(width: 2,),
        Text('$issues'),
      ],
    );
  }
  Widget _getStargazersCount(BuildContext context, int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.stars, color: Theme.of(context).primaryColor, size: 18,),
        SizedBox(width: 2,),
        Text('$count'),
      ],
    );
  }
  Widget _getForks(BuildContext context, int forks) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(CustomIcons.fork, color: Theme.of(context).primaryColor, size: 18,),
        SizedBox(width: 2,),
        Text('$forks'),
      ],
    );
  }
  Widget _getLanguage(BuildContext context, String language) {
    if(language != null && language.isNotEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: langColors.getColor(language),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 2,),
          Text(language),
        ],
      );
    } else {
      return Offstage(offstage: true,);
    }
  }
  Widget _getPushedTime(BuildContext context, String time) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.access_time, color: Theme.of(context).primaryColor, size: 18,),
        SizedBox(width: 2,),
        Text('Pushed on ${Util.getFriendlyDateTime(time) ?? ''}'),
      ],
    );
  }

}