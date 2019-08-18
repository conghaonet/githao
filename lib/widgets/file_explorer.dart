import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/events/repo_home_event.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_content_entity.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/pages/code_preview.dart';
import 'package:githao/pages/image_preview.dart';
import 'package:githao/routes/code_preview_page_args.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/events/app_event_bus.dart';

class FileExplorer extends StatefulWidget {
  final RepoEntity repoEntity;
  FileExplorer(this.repoEntity, {Key key}): super(key: key);
  @override
  _FileExplorerState createState() => _FileExplorerState();
}

class _FileExplorerState extends State<FileExplorer> with AutomaticKeepAliveClientMixin {
  String _currentBranch;
  final List<PathEntity> _paths = [];
  ScrollController _pathScrollController = ScrollController();
  int _tabIndexOfRepoHome = 1;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  bool isLoading = false;

  //要达到缓存目的，必须实现AutomaticKeepAliveClientMixin的wantKeepAlive为true。
  // 不会被销毁,占内存中
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _paths.add(PathEntity('', ' . . ', contents: []));
    _currentBranch = widget.repoEntity.defaultBranch;
    eventBus.on<RepoHomeTabChangedEvent>().listen((event) {
      _tabIndexOfRepoHome = event.tabIndex;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted) {
        refreshIndicatorKey.currentState.show();
      }
    });
  }

  Future<void> _loadContents() async {
    if(isLoading) return Future;
    isLoading = true;
    return ApiService.getRepoContents(widget.repoEntity.owner.login, widget.repoEntity.name,
        _currentBranch, path: _paths.last.path).then((result) {
      //文件夹在前，文件在后。
      result.sort((left, right) {
        if(left.isFile && !right.isFile) {
          return 1;
        } else if(left.isFile && right.isFile) {
            return 0;
        } else {
          return -1;
        }
      });
      _paths.last
        ..contents.clear()
        ..contents.addAll(result);

      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        if(mounted) {
          _pathScrollController.jumpTo(_pathScrollController.position.maxScrollExtent);
        }
      });
    }).catchError((e){
      //如果记载失败，把刚刚添加的path删除
      if(_paths.length>1) {
        _paths.removeLast();
      }
      Util.showToast(e is DioError ? e.message : e.toString());
    }).whenComplete(() {
      if(mounted) {setState(() {});}
      isLoading = false;
      return;
    });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        if(_paths.length <= 1  || _tabIndexOfRepoHome != 1) return true;
        else {
          _paths.removeLast();
          if(mounted) { setState(() {}); }
          return false; //返回上级目录，不pop出当前页面
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
                  leading: _paths.last.contents[index].isFile
                      ? Icon(Icons.insert_drive_file, color: Color(0xff38aa69),)
                      : Icon(Icons.folder , color: Color(0xff02c756),),
                  title: Text(_paths.last.contents[index].name),
                  trailing: _paths.last.contents[index].isFile ? Text('${_paths.last.contents[index].getFormattedSize()}') : null,
                  onTap: () {
                    if(isLoading) return;
                    if(_paths.last.contents[index].isFile) {
                      openFile(index);
                    } else {
                      _paths.add(PathEntity(_paths.last.contents[index].path, _paths.last.contents[index].name, contents: []));
                      refreshIndicatorKey.currentState.show();
                    }
                  },
                );
              },
                childCount: _paths.last.contents.length,
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
      itemCount: _paths.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            if(index + 1 < _paths.length) {
              _paths.removeRange(index+1, _paths.length);
              if(mounted) { setState(() {}); }
            }
          },
          child: Center(
            child: Text('${_paths[index].name}/',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void openFile(int index) {
    var _filePath = _paths.last.contents[index].path;

    var _title = _filePath.substring(_filePath.lastIndexOf('/')+1, _filePath.length);
    var _fileSuffix;
    if(_title.lastIndexOf('.') != -1 && (_title.lastIndexOf('.') + 1) < _title.length) {
      _fileSuffix = _title.substring(_title.lastIndexOf('.')+1, _title.length).toLowerCase();
    }
    if(_fileSuffix !=null && ((_fileSuffix == 'jpg' || _fileSuffix == 'jpeg' || _fileSuffix == 'png' || _fileSuffix == 'gif'))) {
      Navigator.pushNamed(context, ImagePreviewPage.ROUTE_NAME, arguments: _paths.last.contents[index].downloadUrl);
    } else {
      Navigator.pushNamed(
        context,
        CodePreviewPage.ROUTE_NAME,
        arguments: CodePreviewPageArgs(_paths.last.contents[index].path, widget.repoEntity, widget.repoEntity.defaultBranch),);
    }
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
  List<RepoContentEntity> contents;
  PathEntity(this.path, this.name, {this.contents});
}