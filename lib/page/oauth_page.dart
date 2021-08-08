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

  CancelToken cancelToken = CancelToken();
  final Completer<WebViewController> _controller = Completer<WebViewController>();

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
          .accessToken(TokenRequestModel(Const.clientId, Const.clientSecret, code, null), cancelToken: cancelToken)
          .then((tokenEntity) async {
        await prefsManager.setToken(tokenEntity.accessToken);
        showToast(prefsManager.getToken() ?? 'no token');
        githubService.getUser().then((userEntity) async {
          await prefsManager.setUser(userEntity, token: tokenEntity.accessToken);
          showToast(userEntity.login!);
          Navigator.pop(context);
        }).catchError((exception) {
          showToast(exception.toString());
        });
      }).catchError((exception) {
        showToast(exception.toString());
      });
    } catch (e) {
      print(e);
    }
  }
  void _onClickRefresh() async {
    if(!_animController.isAnimating) {
      _animController..reset()..repeat();
      if(_controller.isCompleted) {
        (await _controller.future).reload();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String authorizeUrl = 'https://github.com/login/oauth/authorize?'
        'client_id=${Const.clientId}&redirect_uri=${Const.redirectUri}&scope=${Const.scope}';
    if (!widget.username.isNullOrEmpty()) {
      authorizeUrl += '&login=${widget.username}';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('github.com'),
        centerTitle: true,
        leadingWidth: 80,
        leading: Container(
          margin: EdgeInsets.only(left: 8),
          child: TextButton(
            onPressed: () {
              showToast('aaaaa');
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).cancel_in_title,
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
          _controller.complete(webViewController);
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
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
    cancelToken.cancel();
    _animController.dispose();
    super.dispose();
  }
}

typedef Callback = void Function();
class RefreshIconAnimateWidget extends StatelessWidget {
  final Animation animation;
  final Callback callback;
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
