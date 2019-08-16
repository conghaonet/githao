// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MaterialApp(home: WebViewExampleTab()));

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

class WebViewExampleTab extends StatefulWidget {
  @override
  _WebViewExampleTabState createState() => _WebViewExampleTabState();
}

class _WebViewExampleTabState extends State<WebViewExampleTab> with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _getTabTitles().length, vsync: this);
    _tabController.addListener(() {
    });
  }

  List<String> _getTabTitles() {
    return <String>['info', 'files', 'commits'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView flutter demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _getTabTitles().map((title) => Tab(child: Text(title),)).toList(growable: false),
        ),
      ),
//      body: MyWebView(),

      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(child: MyWebView()),
            ],
          ),
          Container(
            child: Center(
              child: Text('tab A'),
            ),
          ),
          Container(
            child: Center(
              child: Text('tab A'),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        centerTitle: true, //标题居中
        expandedHeight: 200.0, //展开高度200
        backgroundColor: Colors.tealAccent,
        floating: false, //不随着滑动隐藏标题
        pinned: false, //不固定在顶部
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Image.asset(
            "assets/pic.jpg",
            fit: BoxFit.cover,
          ),
        ),
      )
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
/*
  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                final String url = await controller.data.currentUrl();
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Favorited $url')),
                );
              },
              child: const Icon(Icons.favorite),
            );
          }
          return Container();
        });
  }
*/
}

class MyWebView extends StatefulWidget {
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://flutter.dev',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      // TODO(iskakaushik): Remove this when collection literals makes it to stable.
      // ignore: prefer_collection_literals
      javascriptChannels: <JavascriptChannel>[
        _toasterJavascriptChannel(context),
      ].toSet(),
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          print('blocking navigation to $request}');
          return NavigationDecision.prevent;
        }
        print('allowing navigation to $request');
        return NavigationDecision.navigate;
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
      },
    );
  }
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

}

enum MenuOptions {
  showUserAgent,
  listCookies,
  clearCookies,
  addToCache,
  listCache,
  clearCache,
  navigationDelegate,
}

class SampleMenu extends StatelessWidget {
  SampleMenu(this.controller);

  final Future<WebViewController> controller;
  final CookieManager cookieManager = CookieManager();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        return PopupMenuButton<MenuOptions>(
          onSelected: (MenuOptions value) {
            switch (value) {
              case MenuOptions.showUserAgent:
                _onShowUserAgent(controller.data, context);
                break;
              case MenuOptions.listCookies:
                _onListCookies(controller.data, context);
                break;
              case MenuOptions.clearCookies:
                _onClearCookies(context);
                break;
              case MenuOptions.addToCache:
                _onAddToCache(controller.data, context);
                break;
              case MenuOptions.listCache:
                _onListCache(controller.data, context);
                break;
              case MenuOptions.clearCache:
                _onClearCache(controller.data, context);
                break;
              case MenuOptions.navigationDelegate:
                _onNavigationDelegateExample(controller.data, context);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
            PopupMenuItem<MenuOptions>(
              value: MenuOptions.showUserAgent,
              child: const Text('Show user agent'),
              enabled: controller.hasData,
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.listCookies,
              child: Text('List cookies'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCookies,
              child: Text('Clear cookies'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.addToCache,
              child: Text('Add to cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.listCache,
              child: Text('List cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCache,
              child: Text('Clear cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.navigationDelegate,
              child: Text('Navigation Delegate example'),
            ),
          ],
        );
      },
    );
  }

  void _onShowUserAgent(
      WebViewController controller, BuildContext context) async {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    controller.evaluateJavascript(
        'Toaster.postMessage("User Agent: " + navigator.userAgent);');
  }

  void _onListCookies(
      WebViewController controller, BuildContext context) async {
    final String cookies =
    await controller.evaluateJavascript('document.cookie');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Cookies:'),
          _getCookieList(cookies),
        ],
      ),
    ));
  }

  void _onAddToCache(WebViewController controller, BuildContext context) async {
    await controller.evaluateJavascript(
        'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";');
    Scaffold.of(context).showSnackBar(const SnackBar(
      content: Text('Added a test entry to cache.'),
    ));
  }

  void _onListCache(WebViewController controller, BuildContext context) async {
    await controller.evaluateJavascript('caches.keys()'
        '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
        '.then((caches) => Toaster.postMessage(caches))');
  }

  void _onClearCache(WebViewController controller, BuildContext context) async {
    await controller.clearCache();
    Scaffold.of(context).showSnackBar(const SnackBar(
      content: Text("Cache cleared."),
    ));
  }

  void _onClearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _onNavigationDelegateExample(
      WebViewController controller, BuildContext context) async {
    final String contentBase64 =
    base64Encode(const Utf8Encoder().convert(kNavigationExamplePage));
    controller.loadUrl('data:text/html;base64,$contentBase64');
  }

  Widget _getCookieList(String cookies) {
    if (cookies == null || cookies == '""') {
      return Container();
    }
    final List<String> cookieList = cookies.split(';');
    final Iterable<Text> cookieWidgets =
    cookieList.map((String cookie) => Text(cookie));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: cookieWidgets.toList(),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                } else {
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(content: Text("No back history item")),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoForward()) {
                  controller.goForward();
                } else {
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("No forward history item")),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                controller.reload();
              },
            ),
          ],
        );
      },
    );
  }
}

/// 定义tab栏高度
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Container _tabBar;
  _SliverAppBarDelegate(this._tabBar);
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(child: _tabBar,);
  }
  @override
  double get maxExtent => 48;
  @override
  double get minExtent => 48;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}