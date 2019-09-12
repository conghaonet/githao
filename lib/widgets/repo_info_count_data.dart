import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/pages/issues.dart';
import 'package:githao/pages/repo_forks.dart';
import 'package:githao/pages/repo_stargazers.dart';
import 'package:githao/pages/repo_watchers.dart';

class RepoInfoCountData extends StatelessWidget {
  final RepoEntity _repoEntity;
  RepoInfoCountData(this._repoEntity, {Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, IssuesPage.ROUTE_NAME, arguments: _repoEntity.fullName);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                children: <Widget>[
                  Text('${_repoEntity.openIssuesCount ?? 0}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,),),
                  Text(S.current.issues, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, RepoStargazersPage.ROUTE_NAME, arguments: _repoEntity.fullName);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                children: <Widget>[
                  Text('${_repoEntity.stargazersCount ?? 0}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,),),
                  Text(S.current.stargazers, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, RepoForksPage.ROUTE_NAME, arguments: _repoEntity.fullName);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                children: <Widget>[
                  Text('${_repoEntity.forksCount ?? 0}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,),),
                  Text(S.current.forks, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, RepoWatchersPage.ROUTE_NAME, arguments: _repoEntity.fullName);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                children: <Widget>[
                  Text('${_repoEntity.subscribersCount ?? 0}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold,),),
                  Text(S.current.watchers, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

}