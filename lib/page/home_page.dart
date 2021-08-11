import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:githao/app_manager.dart';
import 'package:githao/generated/l10n.dart';
import 'package:githao/network/entity/repos/repo_entity.dart';
import 'package:githao/network/entity/repos/repos_queries_entity.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/network/github_service.dart';
import 'package:githao/notifier/locale_notifier.dart';
import 'package:githao/notifier/theme_notifier.dart';
import 'package:githao/util/const.dart';
import 'package:githao/util/prefs_manager.dart';
import 'package:githao/util/util.dart';
import 'package:githao/widget/app_logo.dart';
import 'package:oktoast/oktoast.dart';
import 'package:githao/util/string_extension.dart';
import 'package:githao/util/number_extension.dart';
import 'package:retrofit/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserEntity _user;
  @override
  void initState() {
    super.initState();
    _user = prefsManager.getUser()!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      drawer: _buildDrawer(),
      body: Container(
        child: AppLogo(),
      ),
    );
  }

  Drawer _buildDrawer() {
    // SvgPicture.asset('asset/github/repo-24.svg')

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
              title: Text(999999999.toFriendly(fractionDigits: 1)),
            ),
            ListTile(
              leading: Util.getSvgIcon('assets/github/repo-24.svg',),
              title: Text(S.of(context).repositories),
              onTap: () async {
                List<RepoEntity> repos = await githubService.getMyRepos(
                  queries: ReposQueriesEntity().toJson(),
                  cacheable: true,
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Util.getSvgIcon('assets/github/repo-24.svg',),
              title: Text(S.of(context).repositories + '(noCache)'),
              onTap: () async {
                List<RepoEntity> repos = await githubService.getMyRepos(
                  queries: ReposQueriesEntity().toJson(),
                  cacheable: false,
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Util.getSvgIcon('assets/github/archive-24.svg'),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings, size: 24,),
              title: Text('Settings'),
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
