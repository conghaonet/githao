import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/pages/user_followers_page.dart';
import 'package:githao/pages/user_following_page.dart';
import 'package:githao/pages/user_repos_page.dart';

class ProfileInfoCountData extends StatelessWidget {
  final UserEntity _userEntity;
  ProfileInfoCountData(this._userEntity, {Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, UserFollowersPage.ROUTE_NAME, arguments: _userEntity.login);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                children: <Widget>[
                  Text('${_userEntity.followers}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,),),
                  Text(S.current.followers, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, UserFollowingPage.ROUTE_NAME, arguments: _userEntity.login);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                children: <Widget>[
                  Text('${_userEntity.following}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,),),
                  Text(S.current.following, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, UserReposPage.ROUTE_NAME, arguments: _userEntity.login);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                children: <Widget>[
                  Text('${_userEntity.publicRepos}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,),),
                  Text(S.current.repositories, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}