import 'package:flutter/material.dart';
import 'package:githao/network/entity/user_entity.dart';

import 'package:githao/pages/home.dart';
import 'package:githao/pages/login.dart';
import 'package:githao/pages/profile.dart';
import 'package:githao/pages/route_error_page.dart';
import 'package:githao/pages/settings.dart';
import 'package:githao/pages/splash.dart';

class AppRoute extends NavigatorObserver {
  AppRoute._internal();
  static final AppRoute _appRoute = AppRoute._internal();
  factory AppRoute() => _appRoute;

  /// 静态路由（无参数）
  static final Map<String, WidgetBuilder> _routes = {
    SplashPage.ROUTE_NAME: (_) => SplashPage(),
    LoginPage.ROUTE_NAME: (_) => LoginPage(),
    HomePage.ROUTE_NAME: (_) => HomePage(),
    SettingsPage.ROUTE_NAME: (_) => SettingsPage(),
//    ProfilePage.ROUTE_NAME: (_) => ProfilePage(),
  };
  Map<String, WidgetBuilder> get routes => _routes;

  /// 带参数路由
  Route<dynamic> generateRoute(RouteSettings settings) {
    MaterialPageRoute targetPage;
    if(settings.name == ProfilePage.ROUTE_NAME) {
      final String login = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return ProfilePage(login);
        },
      );
    }
    //无匹配路由时，跳转到默认错误页面（RouteErrorPage）
    return targetPage ?? MaterialPageRoute(builder: (context) {return RouteErrorPage(route: settings.name);});
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic> previousRoute) {

  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {

  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {

  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if(previousRoute.settings != null && previousRoute.settings.name != null){
      setPreferredOrientations(previousRoute.settings);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if(route.settings != null && route.settings.name != null){
      setPreferredOrientations(route.settings);
    }
  }

  void setPreferredOrientations(RouteSettings settings) {
    /*
    if(targetName == "/") {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      // 恢复系统默认UI：显示状态栏、虚拟按键导航栏
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    } else if(CategoryPage.routeName == targetName) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      // 隐藏状态栏、虚拟按键导航栏
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else if(DetailPage.routeName == targetName) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      // 隐藏状态栏、虚拟按键导航栏
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
    */
  }
}

AppRoute appRoute = AppRoute();
