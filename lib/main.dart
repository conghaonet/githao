import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:githao/network/dio_client.dart';
import 'package:githao/pages/splash_page.dart';
import 'package:githao/provide/locale_provide.dart';
import 'package:githao/provide/theme_provide.dart';
import 'package:githao/provide/user_provide.dart';
import 'package:githao/routes/app_route.dart';
import 'package:githao/utils/app_shared_preferences.dart';
import 'package:githao/utils/sp_util.dart';
import 'package:githao/utils/string_util.dart';
import 'package:provide/provide.dart';

import 'generated/i18n.dart';

// Must be top-level function
_parseAndDecode(String response) => jsonDecode(response);

parseJson(String text) => compute(_parseAndDecode, text);


void main() {
//  await appSP.init();
  //Custom jsonDecodeCallback
  (dioClient.dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

  final providers = Providers()
    ..provide(Provider.value(UserProvide()))
    ..provide(Provider.value(LocaleProvide()))
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
  bool _isInitialed = false;

  @override
  void initState() {
    super.initState();
    _initSp();
  }

  Future _initSp() async {
    await appSP.init();
    //theme初始化
    int themeIndex = SpUtil.getThemeIndex();
    if(themeIndex != null) {
      Provide.value<ThemeProvide>(context).changeTheme(themeIndex);
    }
    //界面语言初始化
    String lang = SpUtil.getLanguage();
    if(StringUtil.isNotEmpty(lang)) {
      Provide.value<LocaleProvide>(context).changeLocale(Locale(lang));
    }
    setState(() {
      _isInitialed = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Provide<LocaleProvide>(
        builder: (context, child, localeProvide) {
          return Provide<ThemeProvide>(
        builder: (context, child, themeProvide) {
          return MaterialApp(
            builder: BotToastInit(),
            locale: localeProvide.locale,
            // 定义静态路由，不能传递参数
            routes: appRoute.routes,
            //动态路由，可传递参数
            onGenerateRoute: appRoute.generateRoute,
            navigatorObservers: [
              appRoute,
              BotToastNavigatorObserver(),
            ],
            // 国际化设置
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate, // for iOS
            ],
            supportedLocales: S.delegate.supportedLocales,
            //指定默认语言
//            localeResolutionCallback: S.delegate.resolution(fallback: const Locale('en','')),
            title: 'githao',
            onGenerateTitle: (context) => S.current.appTitle,
            theme: themeProvide.themeData,
            home: _isInitialed ? SplashPage() : Container(
              color: Colors.white,
              child: Center(
                child: Image.asset('images/icon_app_1024.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      );
  }
    );
  }
}
