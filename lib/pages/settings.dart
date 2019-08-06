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
  static final Border _currentThemeBorder = Border.all(width: 2.0, color: Color(0x66000000));
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

  ExpansionTile _chooseTheme() {
    final List<Widget> themeChildren = [];
    for(int i=0; i<Colors.primaries.length; i++) {
      themeChildren.add(InkWell(
        onTap: () {
          setState(() {
            Provide.value<ThemeProvide>(context).changeTheme(i);
            SystemChrome.setSystemUIOverlayStyle(Provide.value<ThemeProvide>(context).overlayStyle);
            SpUtil.getInstance().then((sp) {
              sp.putInt(SharedPreferencesKeys.themeIndex, i);
            });
          });
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.primaries[i],
            border: Provide.value<ThemeProvide>(context).themeIndex == i ? _currentThemeBorder : null,
          ),
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
    );
  }
}