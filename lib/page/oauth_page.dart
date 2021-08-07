import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/entity/token_request_model.dart';
import 'package:githao/network/github_service.dart';
import 'package:githao/util/const.dart';
import 'package:githao/util/prefs_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OAuthPage extends StatefulWidget {
  const OAuthPage({Key? key}) : super(key: key);

  @override
  _OAuthPageState createState() => _OAuthPageState();
}

class _OAuthPageState extends State<OAuthPage> {
  static const clientId = 'c868cf1dc9c48103bb55';
  final clientSecret = '20bf38742868ad776331c718d98b4670c0eddb8b';
  static const redirectUri = 'http://localhost/oauth/redirect';
  CancelToken cancelToken = CancelToken();
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void _accessToken(String code) async {
    try {
      githubService.accessToken(
          TokenRequestModel(clientId, clientSecret, code, null),
          cancelToken: cancelToken
      ).then((tokenEntity) async {
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

  @override
  Widget build(BuildContext context) {
    // final authorizeUrl = 'https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=${Const.scope}&login=flutter-lib';
    final authorizeUrl = 'https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=${Const.scope}&login=conghaonet';
    return Scaffold(
      appBar: AppBar(

      ),
      body: WebView(
        // initialUrl: 'https://m.baidu.com',
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
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith(redirectUri)) {
            // http://localhost/oauth/redirect?code=514107b8ccd509ed8c48
            final code = Uri.parse(request.url).queryParameters['code'] ?? '';
            if(code.isNotEmpty) {
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
    super.dispose();
  }
}
