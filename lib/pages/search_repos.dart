import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/entity/repo_entity.dart';

class SearchReposPage extends StatefulWidget {
  static const ROUTE_NAME = '/search_repos';
  @override
  _SearchReposPageState createState() => _SearchReposPageState();
}

class _SearchReposPageState extends State<SearchReposPage> {
  List<String> _list = List.generate(100, (i) => 'item $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.search),
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.search),
                onPressed: ()  async {
                  String r = await showSearch(context: context, delegate: SearchReposDelegate());
                },
              );
            },
          ),
        ],
      ),
/*
      body: Container(
        child: Center(
          child: Text('Building...'),
        ),
      ),
*/
      body: ListView(
        children: <Widget>[
          for (var el in _list)
            ListTile(
              title: Text(el),
            ),
        ],
      ),
    );
  }
}

class SearchReposDelegate extends SearchDelegate<String> {
//  final Function() _clearQuery;
  List<String> list = List.generate(100, (i) => 'item $i');

  /// 返回一个控件列表，显示为搜索框右边的图标按钮
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () {
        query = '';
        showSuggestions(context);
      }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    var filterList = list.where((String s) => s.contains(query.trim()));
    return ListView(
      children: <Widget>[
        for (String item in filterList)
          ListTile(
            leading: Icon(
              Icons.message,
              color: Colors.blue,
            ),
            title: Text(
              item,
              style: Theme.of(context).textTheme.title,
            ),
            onTap: () {
              close(context, item);
            },
          ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text(S.current.searchRepositories);
  }

}