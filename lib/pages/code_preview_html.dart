import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/routes/code_preview_page_args.dart';
import 'package:githao/utils/util.dart';

import 'package:webview_flutter/webview_flutter.dart';

class CodePreviewHtmlPage extends StatefulWidget {
  static const ROUTE_NAME = '/code_preivew_html';
  final CodePreviewPageArgs args;
  CodePreviewHtmlPage(this.args, {Key key}): super(key: key);
  @override
  _CodePreviewHtmlPageState createState() => _CodePreviewHtmlPageState();
}

class _CodePreviewHtmlPageState extends State<CodePreviewHtmlPage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  String _title;
  String _content;

  @override
  void initState() {
    super.initState();
    _title = widget.args.contentPath.substring(widget.args.contentPath.lastIndexOf('/')+1, widget.args.contentPath.length);
    ApiService.getRepoContentHtml(
      widget.args.repoEntity.owner.login,
      widget.args.repoEntity.name,
      widget.args.branch,
      widget.args.contentPath,).then((result) async {
      _content = base64Encode(const Utf8Encoder().convert(result));
        var webViewController = await _controller.future;
        webViewController.loadUrl('data:text/html;base64,$_content');
        if(mounted) { setState(() {}); }
      },
    ).catchError((e){
      Util.showToast(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: '',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com.xyz/')) {
                print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
          ),
          Offstage(
            offstage: _content != null,
            child:  Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}