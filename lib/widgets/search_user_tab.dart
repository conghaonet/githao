import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/widgets/user_item.dart';
import 'package:githao/widgets/base_grid.dart';

class SearchUserTab extends StatelessWidget {
  final String query;
  SearchUserTab(this.query, {Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return _UserList(this.query);
  }
}

class _UserList extends BaseGridWidget {
  final String query;
  _UserList(this.query, {Key key}): super(wantKeepAlive: true, crossAxisCount: 2, childAspectRatio: 2, key: key);
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends BaseGridWidgetState<_UserList, UserEntity> {
  @override
  Widget buildItem(UserEntity entity, int index) {
    return UserItem(entity, tag: 'search_user',);
  }

  @override
  Future<List<UserEntity>> getDatum(int expectationPage) {
    return ApiService.searchUsers(keyword: widget.query, page: expectationPage);
  }
}