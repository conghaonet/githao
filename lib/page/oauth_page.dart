import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/generated/l10n.dart';
import 'package:githao/network/entity/token_request_model.dart';
import 'package:githao/network/github_service.dart';
import 'package:githao/util/const.dart';
import 'package:githao/util/prefs_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:githao/util/string_extension.dart';

import 'app_route.dart';

class OAuthPage extends StatefulWidget {
  final String? username;

  const OAuthPage({this.username, Key? key}) : super(key: key);

  static getPageArgs({String? username}) => username;

  @override
  _OAuthPageState createState() => _OAuthPageState();
}

class _OAuthPageState extends State<OAuthPage> with SingleTickerProviderStateMixin {
  late final AnimationController _animController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat();
  late final Animation _animation = Tween(begin: 0.0, end: 2*pi).animate(_animController);

  CancelToken _cancelToken = CancelToken();
  final Completer<WebViewController> _webController = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void didUpdateWidget(OAuthPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // _animController.duration = const Duration(seconds: 1);
  }

  void _accessToken(String code) async {
    try {
      githubService
          .accessToken(TokenRequestModel(Const.clientId, Const.clientSecret, code, null), cancelToken: _cancelToken)
          .then((tokenEntity) async {
        await prefsManager.setToken(tokenEntity.accessToken);
        showToast(prefsManager.getToken() ?? 'no token');
        githubService.getUser().then((userEntity) async {
          await prefsManager.setUser(userEntity, token: tokenEntity.accessToken);
          showToast(userEntity.login!);
          Navigator.pushNamed(context, AppRoute.routeHome);
        }).catchError((exception) {
          showError(exception);
        });
      }).catchError((exception) {
        showError(exception);
      });
    } catch (e) {
      print(e);
    }
  }
  void showError(Object e) {
    if(mounted) {
      showToast(e.toString());
    }
  }
  void _onClickRefresh() async {
    if(!_animController.isAnimating) {
      _animController..reset()..repeat();
      if(_webController.isCompleted) {
        (await _webController.future).reload();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String authorizeUrl = 'https://github.com/login/oauth/authorize?client_id=${Const.clientId}'
        '&redirect_uri=${Uri.encodeFull(Const.redirectUri)}'
        '&scope=${Uri.encodeFull(Const.scope)}';
    if (!widget.username.isNullOrEmpty) {
      authorizeUrl += '&login=${Uri.encodeFull(widget.username!)}';
    }
    debugPrint(authorizeUrl);
    // authorizeUrl = 'https://github.com';
    return Scaffold(
      appBar: AppBar(
        title: Text('github.com'),
        centerTitle: true,
        leadingWidth: 80,
        leading: Container(
          margin: EdgeInsets.only(left: 8),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).cancel,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        actions: [
          // IconButton(onPressed: (){}, icon: Icon(Icons.refresh)),
          RefreshIconAnimateWidget(this._animation, _onClickRefresh),
        ],
      ),
      body: WebView(
        initialUrl: authorizeUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webController.complete(webViewController);
        },
        onPageStarted: (String url) {
          debugPrint('onPageStarted: $url');
        },
        onPageFinished: (String url) {
          debugPrint('onPageFinished: $url');
          _animController.stop();
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith(Const.redirectUri)) {
            // http://localhost/oauth/redirect?code=514107b8ccd509ed8c48
            final code = Uri.parse(request.url).queryParameters['code'] ?? '';
            if (code.isNotEmpty) {
              _accessToken(code);
            } else {
              // http://localhost/oauth/redirect?error=access_denied
              final error = Uri.parse(request.url).queryParameters['error'];
              showToast(error ?? 'token is empty!');
            }
            return NavigationDecision.prevent;
          } else {
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    if(!_cancelToken.isCancelled) _cancelToken.cancel();
    _animController.dispose();
    super.dispose();
  }
}

// typedef Callback = void Function();
class RefreshIconAnimateWidget extends StatelessWidget {
  final Animation animation;
  final VoidCallback callback;
  RefreshIconAnimateWidget(this.animation, this.callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: IconButton(
        onPressed: () => this.callback(),
        icon: Icon(Icons.refresh),
      ),
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: animation.value,
          child: child,
        );
      },
    );
  }
}
