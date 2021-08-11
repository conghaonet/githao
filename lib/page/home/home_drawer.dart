import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:githao/generated/l10n.dart';
import 'package:githao/util/const.dart';
import 'package:githao/util/prefs_manager.dart';
import 'package:githao/widget/app_logo.dart';

import '../home_page.dart';

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
              leading: ImageIcon(Svg('assets/github/repo-24.svg',),),
              title: Text(S.of(context).repositories),
              selected: this.selectedMenu == HomeMenuKey.repos,
              onTap: () => valueChanged(HomeMenuKey.repos),
            ),
            ListTile(
              leading: ImageIcon(Svg('assets/github/organization-24.svg',),),
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