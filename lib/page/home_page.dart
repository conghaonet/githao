import 'package:flutter/material.dart';
import 'package:githao/generated/l10n.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/page/home/home_orgs.dart';
import 'package:githao/page/home/home_settings.dart';
import 'package:githao/page/home/home_repos.dart';
import 'package:githao/util/prefs_manager.dart';

import 'home/home_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserEntity _user;
  late HomeMenuKey _selectedMenu;
  @override
  void initState() {
    super.initState();
    _selectedMenu = HomeMenuKey.repos;
    _user = prefsManager.getUser()!;
  }
  void _onClickDrawer(HomeMenuKey menuKey) async {
    Navigator.pop(context);
    setState(() {
      _selectedMenu = menuKey;
    });
    // switch(menuItemKey) {
    //   case HomeDrawerMenuKey.userRepos: {
    //     List<RepoEntity> repos = await githubService.getMyRepos(
    //         queries: ReposQueriesEntity().toJson(),
    //         cacheable: false,
    //     );
    //     break;
    //   }
    //   default:
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
      ),
      drawer: HomeDrawer(_onClickDrawer, _selectedMenu),
      body: _buildBody(),
    );
  }

  Widget _buildTitle() {
    String titleString;
    switch(_selectedMenu) {
      case HomeMenuKey.repos:
        titleString = S.of(context).repositories;
        break;
      case HomeMenuKey.settings:
        titleString = S.of(context).settings;
        break;
      case HomeMenuKey.organizations:
        titleString = S.of(context).organizations;
        break;
    }
    return Text(titleString);
  }

  Widget _buildBody() {
    switch(_selectedMenu) {
      case HomeMenuKey.repos:
        return HomeRepos();
      case HomeMenuKey.settings:
        return HomeSettings();
      case HomeMenuKey.organizations:
        return HomeOrgs();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum HomeMenuKey {
  repos, settings, organizations
}