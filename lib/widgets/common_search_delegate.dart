import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/utils/sp_util.dart';
import 'package:githao/utils/string_util.dart';
import 'package:githao/utils/util.dart';

class CommonSearchDelegate extends SearchDelegate<String> {
  static const MAX_HISTORY_ITEMS = 50;
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
      onPressed: ()=>
        close(context, null),
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
      _saveHistory();
      close(context, query);

    }
  }

  void _saveHistory() {
    List<String> keys = SpUtil.getSearchHistory();
    if(keys != null) {
      for(int i=0; i<keys.length; i++) {
        if(keys[i].toLowerCase() == query.trim().toLowerCase()) {
          keys.removeAt(i);
          break;
        }
      }
      if(keys.length >= MAX_HISTORY_ITEMS) {
        keys.removeAt(0);
      }
      keys.add(query.trim());
    } else {
      keys = [query.trim()];
    }
    SpUtil.setSearchHistory(keys);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchHistoryWidget(this.close);
  }
}


class SearchHistoryWidget extends StatefulWidget {
  final Function(BuildContext, String ) onClose;
  SearchHistoryWidget(this.onClose, {Key key}):super(key: key);
  @override
  _SearchHistoryWidgetState createState() => _SearchHistoryWidgetState();
}

class _SearchHistoryWidgetState extends State<SearchHistoryWidget> {
  final List<Widget> _histories = [];
  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    List<String> queries = SpUtil.getSearchHistory();
    if(queries != null) {
      queries.reversed.forEach((item) {
        _histories.add(
            Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0XFFcfcfcf),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              child: InkWell(
                onTap: () =>
                  widget.onClose(context, item),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(item),
                ),
              ),
            )
        );
      });
    }
    if(mounted) {setState(() {});}
  }

  @override
  Widget build(BuildContext context) {
    return _histories.isEmpty ? Container() : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: 16),
            Text(S.current.searchHistory),
            Spacer(),
            IconButton(icon: Icon(Icons.delete, color: Theme.of(context).primaryColor,), onPressed: () {
              SpUtil.removeSearchHistory();
              setState(() {
                _histories.clear();
              });
            },),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              children: _histories
            ),
          ),
        ),
      ],
    );
  }
}