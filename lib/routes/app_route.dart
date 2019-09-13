import 'package:flutter/material.dart';
import 'package:githao/network/entity/commit_detail_entity.dart';
import 'package:githao/pages/code_preview.dart';
import 'package:githao/pages/code_preview_html.dart';
import 'package:githao/pages/commit_detail.dart';
import 'package:githao/pages/commit_file_comparison.dart';

import 'package:githao/pages/home.dart';
import 'package:githao/pages/image_preview.dart';
import 'package:githao/pages/issues.dart';
import 'package:githao/pages/login.dart';
import 'package:githao/pages/profile.dart';
import 'package:githao/pages/repo_forks.dart';
import 'package:githao/pages/repo_home.dart';
import 'package:githao/pages/repo_stargazers.dart';
import 'package:githao/pages/repo_watchers.dart';
import 'package:githao/pages/route_error_page.dart';
import 'package:githao/pages/search_repos.dart';
import 'package:githao/pages/settings.dart';
import 'package:githao/pages/splash.dart';
import 'package:githao/pages/user_followers.dart';
import 'package:githao/pages/user_following.dart';
import 'package:githao/pages/user_repos.dart';
import 'package:githao/pages/web_view_page.dart';
import 'package:githao/routes/commit_detail_page_args.dart';
import 'package:githao/routes/webview_page_args.dart';

import 'code_preview_page_args.dart';
import 'profile_page_args.dart';

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
    SearchReposPage.ROUTE_NAME: (_) => SearchReposPage(),
  };
  Map<String, WidgetBuilder> get routes => _routes;

  /// 带参数路由
  Route<dynamic> generateRoute(RouteSettings settings) {
    MaterialPageRoute targetPage;
    if(settings.name == ProfilePage.ROUTE_NAME) {
      final ProfilePageArgs args = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return ProfilePage(args);
        },
      );
    } else if(settings.name == RepoHomePage.ROUTE_NAME) {
      final String args = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return RepoHomePage(args);
        },
      );
    } else if(settings.name == WebViewPage.ROUTE_NAME) {
      final WebViewPageArgs args = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return WebViewPage(args);
        },
      );
    } else if(settings.name == CodePreviewPage.ROUTE_NAME) {
      final CodePreviewPageArgs args = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return CodePreviewPage(args);
        },
      );
    } else if(settings.name == CodePreviewHtmlPage.ROUTE_NAME) {
      final CodePreviewPageArgs args = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return CodePreviewHtmlPage(args);
        },
      );
    } else if(settings.name == ImagePreviewPage.ROUTE_NAME) {
      final String args = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return ImagePreviewPage(args);
        },
      );
    } else if(settings.name == CommitDetailPage.ROUTE_NAME) {
      final CommitDetailPageArgs args = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return CommitDetailPage(args);
        },
      );
    } else if(settings.name == CommitFileComparisonPage.ROUTE_NAME) {
      final CommitDetailFile args = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return CommitFileComparisonPage(args);
        },
      );
    } else if(settings.name == IssuesPage.ROUTE_NAME) {
      final String repoName = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return IssuesPage(repoName: repoName);
        },
      );
    } else if(settings.name == RepoStargazersPage.ROUTE_NAME) {
      final String repoName = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return RepoStargazersPage(repoName);
        },
      );
    } else if(settings.name == RepoForksPage.ROUTE_NAME) {
      final String repoName = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return RepoForksPage(repoName);
        },
      );
    } else if(settings.name == RepoWatchersPage.ROUTE_NAME) {
      final String repoName = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return RepoWatchersPage(repoName);
        },
      );
    } else if(settings.name == UserFollowersPage.ROUTE_NAME) {
      final String login = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return UserFollowersPage(login);
        },
      );
    } else if(settings.name == UserFollowingPage.ROUTE_NAME) {
      final String login = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return UserFollowingPage(login);
        },
      );
    } else if(settings.name == UserReposPage.ROUTE_NAME) {
      final String login = settings.arguments;
      targetPage = MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return UserReposPage(login);
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
