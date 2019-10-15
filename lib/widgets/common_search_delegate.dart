import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/utils/string_util.dart';
import 'package:githao/utils/util.dart';

class CommonSearchDelegate extends SearchDelegate<String> {
  String _lastQuery;
  CommonSearchDelegate(this._lastQuery): super();

  @override
  List<Widget> buildActions(BuildContext context) {
    if(_lastQuery != null && _lastQuery.isNotEmpty) {
      query = _lastQuery;
      _lastQuery = null;
    }
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () {
        query = '';
      }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      // 点击的时候关闭页面（上下文）
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // 不在SearchDelegate中展示搜索结果
    return null;
  }

  /// 不调用buildResults，将query返回给搜索页面，有搜索页面请求并显示搜索结果
  @override
  void showResults(BuildContext context) {
    if(StringUtil.isNullOrBlank(query)) {
      Util.showToast(S.current.queryCanNotBeEmpty);
    } else {
      close(context, query);
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text(S.current.searchHistory);
  }


}