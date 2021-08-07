import 'package:flutter/material.dart';
import 'package:githao/page/launch_page.dart';

import 'home_page.dart';

class AppRoute extends NavigatorObserver {
  static const routeLaunch = '/launch';
  static const routeHome = '/home';

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
    MaterialPageRoute? targetPage;
    return targetPage ?? MaterialPageRoute(builder: (context) {
      return HomePage();
    });
  }
}
AppRoute appRoute = AppRoute();