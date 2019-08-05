import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/provide/theme_provide.dart';
import 'package:githao/utils/shared_preferences.dart';
import 'package:provide/provide.dart';

class SettingsPage extends StatefulWidget {
  static const ROUTE_NAME = "/settings";
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: ListView(
        children: <Widget>[
          _chooseTheme(),
        ],
      ),
    );
  }
  void saveTheme(int themeIndex) async {
    SpUtil spUtil = await SpUtil.getInstance();
    spUtil.putInt(SharedPreferencesKeys.themeIndex, themeIndex);
  }
  ExpansionTile _chooseTheme() {
    final List<Widget> themeChildren = [];
    for(int i=0; i<Colors.primaries.length; i++) {
      themeChildren.add(InkWell(
        onTap: () {
          Provide.value<ThemeProvide>(context).changeTheme(i);
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.primaries[i], //状态栏背景色
            systemNavigationBarColor: Colors.primaries[i], //系统导航栏（虚拟按键）背景色
          ));
          saveTheme(i);
        },
        child: Container(
          width: 50,
          height: 50,
          color: Colors.primaries[i],
        ),
      ));
    }
    return ExpansionTile(
      leading: Icon(Icons.palette),
      title: Text(S.of(context).chooseTheme),
      children: <Widget>[
        Wrap(
          children: themeChildren,),
      ],
      onExpansionChanged: (isOpen) {
        setState(() {

        });
      }
    );
  }
}