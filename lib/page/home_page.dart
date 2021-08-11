import 'dart:async';

import 'package:flutter/material.dart';
import 'package:githao/app_manager.dart';
import 'package:githao/generated/l10n.dart';
import 'package:githao/network/entity/repos/repo_entity.dart';
import 'package:githao/network/entity/repos/repos_queries_entity.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/network/github_service.dart';
import 'package:githao/page/home/home_organizations.dart';
import 'package:githao/page/home/home_settings.dart';
import 'package:githao/page/home/home_repos.dart';
import 'package:githao/util/const.dart';
import 'package:githao/util/prefs_manager.dart';
import 'package:githao/util/util.dart';
import 'package:githao/widget/app_logo.dart';
import 'package:oktoast/oktoast.dart';
import 'package:githao/util/string_extension.dart';
import 'package:githao/util/number_extension.dart';

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
        return HomeOrganizations();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}


class HomeDrawer extends StatelessWidget {
  final HomeMenuKey selectedMenu;
  final ValueChanged<HomeMenuKey> valueChanged;
  const HomeDrawer(this.valueChanged, this.selectedMenu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 32, child: const AppLogo()),
                  const SizedBox(width: 16,),
                  Text(S.of(context).app_name, style: TextStyle(fontSize: 32, fontFamily: Const.font1),),
                ],
              ),
            ),
            const Divider(thickness: 0.5, height: 0.5,),
            ListTile(
              leading: Util.getSvgIcon('assets/github/repo-24.svg',),
              title: Text(S.of(context).repositories),
              selected: this.selectedMenu == HomeMenuKey.repos,
              onTap: () => valueChanged(HomeMenuKey.repos),
            ),
            ListTile(
              leading: Util.getSvgIcon('assets/github/organization-24.svg',),
              title: Text(S.of(context).organizations),
              selected: this.selectedMenu == HomeMenuKey.organizations,
              onTap: () => valueChanged(HomeMenuKey.organizations),
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined,),
              title: Text(S.of(context).settings),
              selected: this.selectedMenu == HomeMenuKey.settings,
              onTap: () => valueChanged(HomeMenuKey.settings),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('System theme'),
              onTap: () {
                prefsManager.setThemeMode(ThemeMode.system);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Light theme'),
              onTap: () {
                prefsManager.setThemeMode(ThemeMode.light);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Dark theme'),
              onTap: () {
                prefsManager.setThemeMode(ThemeMode.dark);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(S.of(context).sing_in_with_github+" system"),
              onTap: () {
                prefsManager.setLocale(null);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(S.of(context).sing_in_with_github+" zh"),
              onTap: () {
                prefsManager.setLocale(Const.zhLocale);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(S.of(context).sing_in_with_github+" en"),
              onTap: () {
                prefsManager.setLocale(Const.enLocale);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class HomeDrawerMenuKey {
//   static const repos = 'repos';
//   static const settings = 'settings';
//   static const organizations = 'organizations';
// }

enum HomeMenuKey {
  repos, settings, organizations
}