import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://news.baidu.com/">https://news.baidu.com/</a></ul>
</ul>
</body>
</html>
''';
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

const String selectedUrl = 'https://flutter.io';

void main() => runApp(MaterialApp(home: FlutterWebViewPluginTab()));

class FlutterWebViewPluginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterWebViewPluginTab',
      home: FlutterWebViewPluginTab(),
    );
  }

}

class FlutterWebViewPluginTab extends StatefulWidget {
  @override
  _FlutterWebViewPluginTabState createState() => _FlutterWebViewPluginTabState();
}

class _FlutterWebViewPluginTabState extends State<FlutterWebViewPluginTab> with TickerProviderStateMixin {
  static final List<String> titles = ['tab1', 'tab2'];
  TabController _tabController;
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.close();
    _tabController = TabController(length: titles.length, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterWebViewPluginTab'),
        bottom: TabBar(
          controller: _tabController,
          tabs: titles.map((title) => Tab(child: Text(title),)).toList(growable: false),
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Center(
              child: Text('tab1'),
            ),
/*
            WebviewScaffold(
              url: Uri.dataFromString(kNavigationExamplePage, mimeType: 'text/html').toString(),
//          url: "https://github.com/octokit/octokit.rb/blob/master/README.md",
            ),
*/
            Container(
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    flutterWebViewPlugin.launch(
                      selectedUrl,
                      rect: Rect.fromLTWH(0.0, 120.0, MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                      userAgent: kAndroidUserAgent,
                      invalidUrlRegex: r'^(https).+(twitter)', // prevent redirecting to twitter when user click on its icon in flutter website
                    );
                  },
                  child: const Text('Open Webview (rect)'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}