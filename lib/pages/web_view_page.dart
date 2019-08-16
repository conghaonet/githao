import 'dart:async';

import 'package:flutter/material.dart';
import 'package:githao/routes/webview_page_args.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  static const ROUTE_NAME = '/webview_page';
  final WebViewPageArgs args;
  WebViewPage(this.args, {Key key}): super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  String title;
  @override
  void initState() {
    super.initState();
    title = widget.args.title;
    if(title == null) {
      title = widget.args.url.substring(widget.args.url.lastIndexOf('/')+1, widget.args.url.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${title ?? ''}', style: TextStyle(fontSize: 18),),
        titleSpacing: 0,
        actions: <Widget>[
          NavigationControls(_controller.future),
        ],
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.args.url,
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
/*
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
*/
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
        ),
      ),
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

class NavigationControls extends StatelessWidget {
  final Future<WebViewController> _webViewControllerFuture;
  const NavigationControls(this._webViewControllerFuture): assert(_webViewControllerFuture != null);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder: (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady = snapshot.connectionState == ConnectionState.done;
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