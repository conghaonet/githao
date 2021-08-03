import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  static const clientId = 'c868cf1dc9c48103bb55';
  final clientSecret = '20bf38742868ad776331c718d98b4670c0eddb8b';
  static const redirectUri = 'http://localhost/oauth/redirect';
  static const login = 'conghaonet';
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
      var response = await Dio().post(
          'https://github.com/login/oauth/access_token',
          data: {
            'client_id': clientId,
            'client_secret': clientSecret,
            'code': code
          },
          cancelToken: cancelToken
      );
      showToast(response.headers.toString());
      // access_token=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&scope=&token_type=bearer

      print(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authorizeUrl = 'https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&login=$login';
    return Scaffold(
      appBar: AppBar(

      ),
      body: WebView(
        initialUrl: 'https://m.baidu.com',
        // initialUrl: authorizeUrl,
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
            final code = Uri.parse(request.url).queryParameters['code'];
            _accessToken(code ?? '');
            return NavigationDecision.navigate;
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
