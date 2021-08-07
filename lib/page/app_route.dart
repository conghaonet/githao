import 'package:flutter/material.dart';
import 'package:githao/page/launch_page.dart';
import 'package:githao/page/oauth_page.dart';

import 'home_page.dart';

class AppRoute extends NavigatorObserver {
  static const routeLaunch = '/launch';
  static const routeHome = '/home';
  static const routeOAuth = '/oauth_page';

  factory AppRoute() => _appRoute;
  AppRoute._internal();
  static final AppRoute _appRoute = AppRoute._internal();

  /// 静态路由（无参数）
  static final Map<String, WidgetBuilder> _routes = {
    routeLaunch: (_) => LaunchPage(),
    routeHome: (_) => HomePage(),
  };
  Map<String, WidgetBuilder> get routes => _routes;

  /// 带参数路由
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case routeOAuth: {
        return MaterialPageRoute(settings: settings,
          builder: (context) => OAuthPage(username: settings.arguments?.toString()),
        );
      }
      default:
        return MaterialPageRoute(builder: (context) {return HomePage();});
    }
  }
}
AppRoute appRoute = AppRoute();