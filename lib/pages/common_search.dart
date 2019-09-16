import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/common_search_delegate.dart';

class CommonSearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/common_search';
  @override
  _CommonSearchPageState createState() => _CommonSearchPageState();
}

class _CommonSearchPageState extends State<CommonSearchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted) {
        Future.delayed(const Duration(milliseconds: 100)).then((_) {
          if(mounted) {
            showSearch<String>(context: context, delegate: CommonSearchDelegate());
          }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.search),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search), onPressed: () async {
            String query = await showSearch<String>(context: context, delegate: CommonSearchDelegate());
            Util.showToast(query ?? 'query is null');
          }),
        ],
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
