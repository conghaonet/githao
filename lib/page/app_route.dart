import 'package:flutter/material.dart';
import 'package:githao_v2/page/launch_page.dart';

class AppRoute extends NavigatorObserver {
  static const routeLaunch = '/launch';
  static const routeHome = '/home';

  factory AppRoute() => _appRoute;
  AppRoute._internal();
  static final AppRoute _appRoute = AppRoute._internal();

  /// 静态路由（无参数）
  static final Map<String, WidgetBuilder> _routes = {
    routeLaunch: (_) => LaunchPage()
  };
  Map<String, WidgetBuilder> get routes => _routes;
}
AppRoute appRoute = AppRoute();