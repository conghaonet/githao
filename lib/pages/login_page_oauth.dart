import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:githao/biz/user_biz.dart';
import 'package:githao/generated/i18n.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:githao/network/entity/token_request_model.dart';
import 'package:githao/pages/home_page.dart';
import 'package:githao/provide/user_provide.dart';
import 'package:githao/utils/string_util.dart';
import 'package:githao/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yaml/yaml.dart';

class LoginPageOAuth extends StatefulWidget {
  static const ROUTE_NAME = "/login";
  final String username;
  const LoginPageOAuth({this.username, Key key}) : super(key: key);

  @override
  State<LoginPageOAuth> createState() => _LoginPageOAuthState();
}

class _LoginPageOAuthState extends State<LoginPageOAuth> with SingleTickerProviderStateMixin {
  AnimationController _animController;
  Animation _animation;

  CancelToken _cancelToken = CancelToken();
  final Completer<WebViewController> _webController = Completer<WebViewController>();

  String clientId;
  String clientSecret;
  String callbackUrl;
  String authorizeUrl;

  @override
  void didUpdateWidget(LoginPageOAuth oldWidget) {
    super.didUpdateWidget(oldWidget);
    // _animController.duration = const Duration(seconds: 1);
  }
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _animController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    _animation = Tween(begin: 0.0, end: 2*pi).animate(_animController);
    Future(() async {
      String str = await rootBundle.loadString('github.yaml');
      var doc = loadYaml(str);
      clientId = doc['github']['oauth_app']['client_id'];
      clientSecret = doc['github']['oauth_app']['client_secret'];
      callbackUrl = doc['github']['oauth_app']['callback_url'];

      if(clientId != null && callbackUrl != null) {
        authorizeUrl = 'https://github.com/login/oauth/authorize?client_id=$clientId'
            '&redirect_uri=${Uri.encodeFull(callbackUrl)}'
            '&scope=${Uri.encodeFull('repo user admin:org notifications read:discussion')}'
            '${!StringUtil.isNullOrEmpty(widget.username) ? "&login=${Uri.encodeFull(widget.username)}" : ""}';

        debugPrint(authorizeUrl);
      }
      if(mounted) {
        setState(() {
        });
      }
    });
    super.initState();
  }

  void _onClickRefresh() async {
    if(!_animController.isAnimating) {
      _animController..reset()..repeat();
      if(_webController.isCompleted) {
        (await _webController.future).reload();
      }
    }
  }
  void showError(Object e) {
    if(mounted) {
      Util.showToast(e.toString());
    }
  }

  void _accessToken(String code) async {
    try {
      UserBiz.loginOauth(TokenRequestModel(clientId, clientSecret, code, null)).then((userEntity) async {
        if(userEntity != null ) {
          context.read<UserProvide>().updateUser(userEntity);
          Navigator.of(context).pushReplacementNamed(HomePage.ROUTE_NAME);
        } else {
          throw Exception("获取用户信息出错！");
        }
      }).catchError((e) {
        showError(e);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          RefreshIconAnimateWidget(this._animation, _onClickRefresh),
        ],
      ),
      body: authorizeUrl == null ? Container() : WebView(
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
          if (request.url.startsWith(callbackUrl)) {
            // http://localhost/oauth/redirect?code=514107b8ccd509ed8c48
            final code = Uri.parse(request.url).queryParameters['code'] ?? '';
            if (code.isNotEmpty) {
              _accessToken(code);
            } else {
              // http://localhost/oauth/redirect?error=access_denied
              final error = Uri.parse(request.url).queryParameters['error'];
              Util.showToast(error ?? 'token is empty!');
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


class RefreshIconAnimateWidget extends StatelessWidget {
  final Animation animation;
  final VoidCallback callback;
  RefreshIconAnimateWidget(this.animation, this.callback, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: IconButton(
        onPressed: () => this.callback(),
        icon: Icon(Icons.refresh),
      ),
      builder: (BuildContext context, Widget child) {
        return Transform.rotate(
          angle: animation.value,
          child: child,
        );
      },
    );
  }
}