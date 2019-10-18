import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/resources/search_users_filter_parameters.dart';
import 'package:githao/widgets/search_users_filter.dart';
import 'package:githao/widgets/user_item.dart';
import 'package:githao/widgets/base_grid.dart';

class SearchUserTab extends StatefulWidget {
  final String query;
  SearchUserTab(this.query, {Key key}): super(key: key);

  @override
  _SearchUserTabState createState() => _SearchUserTabState();
}

class _SearchUserTabState extends State<SearchUserTab> {
  int _sortIndex = 0;

  void onClickFilterCallback(int index) {
    if(_sortIndex != index) {
      setState(() {
        _sortIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _UserList(this.widget.query, _sortIndex, key: Key('user_${this.widget.query}_$_sortIndex'),),
        Positioned(
          bottom: 12,
          right: 16,
          child: FloatingActionButton(
            heroTag: 'search_user_tab_fab',
            child: Icon(Icons.sort),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets,  //边距（必要）
                    duration: const Duration(milliseconds: 100), //时常 （必要）
                    child: SearchUsersFilter(
                      this._sortIndex,
                      onClickFilterCallback,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _UserList extends BaseGridWidget {
  final String query;
  final int sortIndex;
  _UserList(this.query, this.sortIndex, {Key key}): super(wantKeepAlive: true, crossAxisCount: 2, key: key);
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends BaseGridWidgetState<_UserList, UserEntity> {
  @override
  Widget buildItem(UserEntity entity, int index) {
    return UserItem(entity, tag: 'search_user_tab_list',);
  }

  @override
  Future<List<UserEntity>> getDatum(int expectationPage) {
    String _sort = SearchUsersFilterParameters.filterSortValueMap[this.widget.sortIndex][SearchUsersFilterParameters.PARAMETER_NAME_SORT];
    String _direction = SearchUsersFilterParameters.filterSortValueMap[this.widget.sortIndex][SearchUsersFilterParameters.PARAMETER_NAME_DIRECTION];
    return ApiService.searchUsers(keyword: widget.query, sort: _sort, order: _direction, page: expectationPage);
  }
}