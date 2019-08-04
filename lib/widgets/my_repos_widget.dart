import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/utils/util.dart';

/// [perPageRows] 每次请求期望返回的数据量，GitHub默认每次返回30条数据；
/// [hasLoadingMore] 为true时，提供上拉加载更多特性；
/// [shrinkWrap] see [ScrollView.shrinkWrap]
/// [primary] see [ScrollView.primary]
class MyReposWidget extends StatefulWidget{
  final perPageRows = 30;
  final hasLoadingMore;
  final bool shrinkWrap;
  final bool primary;

  MyReposWidget({Key key, this.hasLoadingMore=true, this.shrinkWrap = false, this.primary = true}): super(key: key);
  @override
  _MyReposWidgetState createState() => _MyReposWidgetState();
}

class _MyReposWidgetState extends State<MyReposWidget> {
  final List<RepoEntity> repos = [];
  int page = 1;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadRepos(true);
  }
  Future loadRepos(bool isReload) async {
    if(isLoading) return null;
    isLoading = true;
    int expectationPage;
    if (isReload)
      expectationPage = 1;
    else
      expectationPage = page + 1;
    return ApiService.getRepos(page: expectationPage).then<bool>((repos) {
      setState(() {
        if (isReload) {
          this.repos
            ..clear()
            ..addAll(repos);
          page = 1;
        } else {
          ++page;
          this.repos.addAll(repos);
        }
        isLoading = false;
      });
      return;
    }).catchError((e) {
      isLoading = false;
      Util.showToast(e.toString());
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        color: Colors.blue,
        onRefresh: () async {
          await loadRepos(true);
        },
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if(widget.hasLoadingMore) { //是否需要实现加载更多特性
              if(0 == notification.metrics.extentAfter) { //到达底部
                if(repos.length >= (widget.perPageRows * page)) {
                  loadRepos(false);
                }
              }
            }
            return false; //返回false，将事件传递给外层控件(RefreshIndicator)，否则外层RefreshIndicator无法监听到下拉手势
          },
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(height: 4, color: Theme.of(context).primaryColor,);
            },
            padding: EdgeInsets.all(0.0),
            shrinkWrap: widget.shrinkWrap,
            primary: widget.primary,
            itemCount: (repos.length >= (widget.perPageRows * 1)) ? repos.length+1 : repos.length,
            itemBuilder: (context, index) {
              if(index < repos.length) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('index：$index'),
                    Text('name: ${repos[index].name}'),
                    Text('language: ${repos[index].language}'),
                    Text('description: ${repos[index].description}'),
                    Text('pushedAt: ${repos[index].pushedAt}'),
                  ],
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightGreen,
                  child: Text('加载更多。。。'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}