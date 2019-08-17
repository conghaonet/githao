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
  final List<PathEntity> _paths = [];
  ScrollController _pathScrollController = ScrollController();

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

  Future<void> _loadContents() async {
    return ApiService.getRepoContents(widget.repoEntity.owner.login, widget.repoEntity.name,
        _currentBranch, path: _paths.isEmpty ? '' : _paths.last.path).then((result) {
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
      if(mounted) {setState(() {});}
      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        if(mounted) {
          _pathScrollController.jumpTo(_pathScrollController.position.maxScrollExtent);
        }
      });
      return;
    }).catchError((e){
      Util.showToast(e is DioError ? e.message : e.toString());
      return;
    });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        if(_paths.isEmpty) return true;
        else {
          _paths.removeLast();
          refreshIndicatorKey.currentState.show();
          return false;
        }
      },
      child: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: _loadContents,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: _SliverAppBarDelegate(
                Container(
                  height: 48,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: _buildPathsView(),
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
                      _paths.add(PathEntity(_contents[index].path, _contents[index].name));
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
      ),
    );
  }

  ListView _buildPathsView() {
    return ListView.builder(
      controller: _pathScrollController,
      scrollDirection: Axis.horizontal,
      itemCount: _paths.length+1,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            if(index == 0) {
              _paths.clear();
            } else if(index < _paths.length) {
              _paths.removeRange(index, _paths.length);
            }
            refreshIndicatorKey.currentState.show();
          },
          child: Center(
            child: Text(
              index == 0  ?  ' . . /' : '${_paths[index-1].name}/',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
  @override
  void dispose() {
    _pathScrollController.dispose();
    super.dispose();
  }
}

/// 定义tab栏高度
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget _tabBar;
  final int tabIndex;
  _SliverAppBarDelegate(this._tabBar, {this.tabIndex});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }
  @override
  double get maxExtent => 48;
  @override
  double get minExtent => 48;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class PathEntity {
  final String path;
  final String name;
  const PathEntity(this.path, this.name);
}