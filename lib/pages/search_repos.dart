
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/pages/repo_home.dart';
import 'package:githao/utils/util.dart';

class SearchReposPage extends StatefulWidget {
  static const ROUTE_NAME = '/search_repos';
  @override
  _SearchReposPageState createState() => _SearchReposPageState();
}

class _SearchReposPageState extends State<SearchReposPage> {
  @override
  void initState() {
    super.initState();
/*
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted) {
        Future.delayed(const Duration(milliseconds: 100)).then((_) {
          if(mounted) {
            showSearch<String>(context: context, delegate: SearchReposDelegate(context));
          }
        });
      }
    });
*/
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.search),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search), onPressed: () async {
            String query = await showSearch<String>(context: context, delegate: SearchReposDelegate(context));
            Util.showToast(query);
          }),
        ],
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}

class SearchReposDelegate extends SearchDelegate<String> {
  final BuildContext _context;
  List<RepoEntity> _repos = [];
  AsyncMemoizer _memoizer = AsyncMemoizer();
  int _page = 1;

  SearchReposDelegate(this._context): super();

  Future<List<RepoEntity>> _loadData({bool isReload = true}) async {

    return await _memoizer.runOnce(() async {
      return ApiService.searchRepos(keyword: query, page: _page).then((result){
        if(isReload) {
          _repos.clear();
        }
        _repos.addAll(result);
        return _repos;
      }).whenComplete((){
        if(_page<2) {
          ++_page;
          Future.delayed(const Duration(seconds: 3), () {
            _memoizer = AsyncMemoizer();
            super.showResults(_context);
//            _loadData(isReload: false);
          });
        }
      });
    });

  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _createListView(context, snapshot);
      default:
        return null;
    }
  }

  Widget _createListView(BuildContext context, AsyncSnapshot<List<RepoEntity>> snapshot) {
    List<RepoEntity> entities = snapshot.data;
    return ListView.builder(
      itemBuilder: (context, index) => _itemBuilder(context, index, entities[index]),
      itemCount: entities.length,
    );
  }

  Widget _itemBuilder(BuildContext context, int index, RepoEntity entity) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, RepoHomePage.ROUTE_NAME, arguments: entity.fullName);
      },
      leading: Text('( $index)'),
      title: Text(entity.fullName),
    );
  }

  /// 返回一个控件列表，显示为搜索框右边的图标按钮
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () {
        query = '';
//        showSuggestions(context);
      }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      // 点击的时候关闭页面（上下文）
      onPressed: (){
        close(context, query);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print('buildResults >>>>' + query);
    close(context, query);
    return Container(color: Colors.blue,);
/*
    return WillPopScope(
      onWillPop: () async {
        close(context, query);
        return true;
      },
      child: FutureBuilder(builder: _buildFuture, future: _loadData(),),
    );
*/
  }

  @override
  void showResults(BuildContext context) {
//    super.showResults(context);
    print('showResults >>>>' + query);
    close(context, query);
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    print('buildSuggestions >>>>' + query);
    return WillPopScope(
      onWillPop: () async {
        close(context, query);
        return true;
      },
      child: Text(S.current.searchRepositories),
    );
  }

}