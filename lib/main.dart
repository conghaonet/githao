import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:githao/pages/login.dart';

import 'generated/i18n.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.deepOrange, //状态栏背景色
    statusBarIconBrightness: Brightness.light, //状态栏图标颜色，白色：Brightness.light，黑色：Brightness.dark
    systemNavigationBarColor: Colors.deepOrange, //系统导航栏（虚拟按键）背景色
    systemNavigationBarIconBrightness: Brightness.light, //系统导航栏按键（虚拟按键）颜色，白色：Brightness.light，黑色：Brightness.dark
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
//      localeResolutionCallback: S.delegate.resolution(fallback: const Locale('en', '')),
      title: 'githao',
      onGenerateTitle: (context) => S.of(context).appTitle,
      theme: ThemeData(
//        brightness: Brightness.light,
//        primaryColor: Colors.deepOrangeAccent,
        primarySwatch: Colors.deepOrange,
        cursorColor: Colors.deepOrange, //光标颜色
//        accentColor: Colors.deepOrangeAccent,
      ),
      home: LoginPage(),
    );
  }
}
