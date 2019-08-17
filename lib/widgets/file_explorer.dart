import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_content_entity.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/utils/util.dart';
class FileExplorer extends StatefulWidget {
  final RepoEntity repoEntity;
  FileExplorer(this.repoEntity, {Key key}): super(key: key);
  @override
  _FileExplorerState createState() => _FileExplorerState();
}

class _FileExplorerState extends State<FileExplorer> with AutomaticKeepAliveClientMixin {
  final List<RepoContentEntity> _contents = [];
  String _currentBranch;
  final List<String> _paths = [];
  String _path;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  //要达到缓存目的，必须实现AutomaticKeepAliveClientMixin的wantKeepAlive为true。
  // 不会被销毁,占内存中
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _currentBranch = widget.repoEntity.defaultBranch;
    WidgetsBinding.instance.addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
  }

  Future<void> _reloadContents() async {
    if(_path == null) _path = '';
    return ApiService.getRepoContents(widget.repoEntity.owner.login, widget.repoEntity.name, _currentBranch, path: _path).then((result) {
      _contents.clear();
      _contents.addAll(result);
      //文件夹在前，文件在后。
      _contents.sort((left, right) {
        if(left.isFile && !right.isFile) {
          return 1;
        } else if(left.isFile && right.isFile) {
            return 0;
        } else {
          return -1;
        }
      });
      if(mounted) {
        setState(() {

        });
      }
      return;
    }).catchError((e){
      Util.showToast(e is DioError ? e.message : e.toString());
      return;
    });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: _reloadContents,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: _SliverAppBarDelegate(
              Container(
                height: 48,
                color: Colors.blue,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Text('aaaaaaaaaaaaaaaaaaaaaaaaaa'),
                      Text('bbbbbbbbbbbbbbbbbbbbbbbbbb'),
                      Text('cccccccccccccccccccccccccc'),
                      Text('dddddddddddddddddddddddddd'),
                      Text('eeeeeeeeeeeeeeeeeeeeeeeeee'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              return ListTile(
                leading: _contents[index].isFile
                    ? Icon(Icons.insert_drive_file, color: Color(0xff38aa69),)
                    : Icon(Icons.folder , color: Color(0xff02c756),),
                title: Text(_contents[index].name),
                trailing: _contents[index].isFile ? Text('${_contents[index].getFormattedSize()}') : null,
                onTap: () {
                  if(_contents[index].isFile) {
                    //TODO 打开文件
                  } else {
                    _path = _contents[index].path;
                    refreshIndicatorKey.currentState.show();
                  }
                },
              );
            },
              childCount: _contents.length,
            ),
          ),
        ],
      ),
    );
  }
}

/// 定义tab栏高度
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Container _tabBar;
  final int tabIndex;
  _SliverAppBarDelegate(this._tabBar, {this.tabIndex});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(child: _tabBar,);
  }
  @override
  double get maxExtent => 48;
  @override
  double get minExtent => 48;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}