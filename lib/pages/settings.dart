import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/provide/locale_provide.dart';
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
  String selectedLanguage = '';
  @override
  void initState() {
    super.initState();
    SpUtil.instance.then((sp){
      String lang = sp.getString(SharedPreferencesKeys.language);
      setState(() {
        if(lang == null) {
          selectedLanguage = '';
        } else {
          selectedLanguage = lang;
        }
      });
    });
  }
  void _changeLanguage(String languageCode) {
    setState(() {
      selectedLanguage = languageCode;
      SpUtil.instance.then((sp) {
        sp.putString(SharedPreferencesKeys.language, selectedLanguage);
      });
      Locale locale = (selectedLanguage==null || selectedLanguage.isEmpty) ? null : Locale(languageCode);
      Provide.value<LocaleProvide>(context).changeLocale(locale);
    });
  }
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
            title: Text(S.current.language, style: TextStyle(color: Theme.of(context).primaryColor),),
            subtitle: Text(getLanguageUiString(selectedLanguage)),
            onTap: () {
              showDialog<void>(context: context, barrierDismissible: true, builder: (BuildContext context){
                return AlertDialog(
                  title: Text(S.current.language),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RadioListTile(
                        title: Text(getLanguageUiString('')),
                        value: '',
                        groupValue: selectedLanguage,
                        onChanged: (String languageCode) {
                          _changeLanguage(languageCode);
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile(
                        title: Text(getLanguageUiString(S.delegate.supportedLocales[0].languageCode)),
                        value: S.delegate.supportedLocales[0].languageCode,
                        groupValue: selectedLanguage,
                        onChanged: (String languageCode) {
                          _changeLanguage(languageCode);
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile(
                        title: Text(getLanguageUiString(S.delegate.supportedLocales[1].languageCode)),
                        value: S.delegate.supportedLocales[1].languageCode,
                        groupValue: selectedLanguage,
                        onChanged: (String languageCode) {
                          _changeLanguage(languageCode);
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
  
  String getLanguageUiString(String languageCode) {
    String uiString = S.current.systemDefault;
    switch(languageCode.toLowerCase()) {
      case 'en':
        uiString = S.current.english;
        break;
      case 'zh':
        uiString = S.current.chineseSimplified;
    }
    return uiString;
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
      title: Text(S.current.chooseTheme, style: TextStyle(color: Theme.of(context).primaryColor),),
      children: <Widget>[
        Wrap(
          children: themeChildren,),
      ],
    );
  }
}