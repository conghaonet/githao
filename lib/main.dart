import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:githao/pages/splash.dart';
import 'package:githao/provide/theme_provide.dart';
import 'package:githao/provide/user_provide.dart';
import 'package:githao/routes/app_route.dart';
import 'package:githao/utils/shared_preferences.dart';
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
  void initState() {
    super.initState();
    SpUtil.getInstance().then((sp) {
      //theme初始化
      int themeIndex = sp.getInt(SharedPreferencesKeys.themeIndex);
      if(themeIndex != null) {
        Provide.value<ThemeProvide>(context).changeTheme(themeIndex);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Provide<ThemeProvide>(
      builder: (context, child, themeProvide) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          statusBarColor: themeProvide.themeData.primaryColor, //状态栏背景色
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: themeProvide.themeData.primaryColor, //系统导航栏（虚拟按键）背景色
          systemNavigationBarIconBrightness: Brightness.dark,
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
          theme: themeProvide.themeData,
          home: SplashPage(),
        );
      },
    );
  }
}
