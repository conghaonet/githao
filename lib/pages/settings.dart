import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/provide/theme_provide.dart';
import 'package:githao/utils/shared_preferences.dart';
import 'package:githao/utils/util.dart';
import 'package:provide/provide.dart';

class SettingsPage extends StatefulWidget {
  static const ROUTE_NAME = "/settings";
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static final Border _currentThemeBorder = Border.all(width: 2.0, color: Color(0x66000000));
  String selectedLanguageTag = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.settings),
      ),
      body: ListView(
        children: <Widget>[
          _chooseTheme(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(S.current.language),
            onTap: () {
              showDialog<void>(context: context, barrierDismissible: true, builder: (BuildContext context){
                return AlertDialog(
                  title: Text(S.current.language),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RadioListTile(
                        title: Text(S.current.systemDefault),
                        value: '',
                        groupValue: selectedLanguageTag,
                        onChanged: (String languageTag) {
                          selectedLanguageTag = languageTag;
                          Util.showToast(languageTag);
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile(
                        title: Text(S.current.english),
                        value: S.delegate.supportedLocales[0].toLanguageTag(),
                        groupValue: selectedLanguageTag,
                        onChanged: (String languageTag) {
                          selectedLanguageTag = languageTag;
                          Util.showToast(languageTag);
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile(
                        title: Text(S.current.chineseSimplified),
                        value: S.delegate.supportedLocales[1].toLanguageTag(),
                        groupValue: selectedLanguageTag,
                        onChanged: (String languageTag) {
                          selectedLanguageTag = languageTag;
                          Util.showToast(languageTag);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              });
            },
          ),
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
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.primaries[i],
            border: Provide.value<ThemeProvide>(context).themeIndex == i ? _currentThemeBorder : null,
          ),
        ),
      ));
    }
    return ExpansionTile(
      leading: Icon(Icons.palette),
      title: Text(S.current.chooseTheme),
      children: <Widget>[
        Wrap(
          children: themeChildren,),
      ],
    );
  }
}