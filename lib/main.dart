import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:githao/pages/splash.dart';
import 'package:githao/provide/theme_provide.dart';
import 'package:githao/provide/user_provide.dart';
import 'package:githao/routes/app_route.dart';
import 'package:provide/provide.dart';

import 'generated/i18n.dart';

void main() {
  final providers = Providers()
    ..provide(Provider.value(UserProvide()))
    ..provide(Provider.value(ThemeProvide()));
  runApp(ProviderNode(
    providers: providers,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Provide<ThemeProvide>(
      builder: (context, child, themeProvide) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.primaries[themeProvide.themeIndex], //状态栏背景色
          statusBarIconBrightness: Brightness.light, //状态栏图标颜色，白色：Brightness.light，黑色：Brightness.dark
          systemNavigationBarColor: Colors.primaries[themeProvide.themeIndex], //系统导航栏（虚拟按键）背景色
          systemNavigationBarIconBrightness: Brightness.light, //系统导航栏按键（虚拟按键）颜色，白色：Brightness.light，黑色：Brightness.dark
        ));
        return MaterialApp(
          // 定义静态路由，不能传递参数
          routes: appRoute.routes,
          //动态路由，可传递参数
          onGenerateRoute: appRoute.generateRoute,
          navigatorObservers: [
            appRoute,
          ],
          // 国际化设置
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          //指定默认语言
          //localeResolutionCallback: S.delegate.resolution(fallback: const Locale('en', '')),
          title: 'githao',
          onGenerateTitle: (context) => S.of(context).appTitle,
          theme: ThemeData(
            primarySwatch:Colors.primaries[themeProvide.themeIndex],
          ),
/*
        theme: ThemeData(
//        brightness: Brightness.light,
//        primaryColor: Colors.deepOrangeAccent,
          primarySwatch: Colors.deepOrange,
          cursorColor: Colors.deepOrange, //光标颜色
//        accentColor: Colors.deepOrangeAccent,
        ),
*/
          home: SplashPage(),
        );
      },
    );
  }
}
