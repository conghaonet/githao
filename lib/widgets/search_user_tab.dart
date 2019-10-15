import 'package:flutter/material.dart';
import 'package:githao/events/app_event_bus.dart';
import 'package:githao/events/search_event.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/utils/string_util.dart';
import 'package:githao/widgets/user_item.dart';
import 'package:githao/widgets/base_grid.dart';

class SearchUserTab extends StatelessWidget {
  final String category;
  SearchUserTab(this.category, {Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return _UserList(this.category);
  }
}

class _UserList extends BaseGridWidget {
  final String category;
  _UserList(this.category, {Key key}): super(crossAxisCount: 2, childAspectRatio: 2, key: key);
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends BaseGridWidgetState<_UserList, UserEntity> {
  String _query;

  @override
  Widget buildItem(UserEntity entity, int index) {
    return UserItem(entity, tag: 'search_user',);
  }

  @override
  Future<List<UserEntity>> getDatum(int expectationPage) {
    if(StringUtil.isNotBlank(this._query)) {
      return ApiService.searchUsers(keyword: _query, page: expectationPage);
    } else {
      return null;
    }
  }

  @override
  void afterInitState() {
    eventBus.on<SearchEvent>().listen((event) {
      if(StringUtil.isNullOrBlank(event.category) || event.category == widget.category) {
        this._query = event.query;
        if (StringUtil.isNotBlank(this._query)) {
          super.refreshIndicatorKey?.currentState?.show();
        }
      }
    });
  }

}