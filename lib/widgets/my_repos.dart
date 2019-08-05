import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/utils/util.dart';

import 'load_more_data_footer.dart';

/// [perPageRows] 每次请求期望返回的数据量，GitHub默认每次返回30条数据；
/// [needLoadMore] 为true时，提供上拉加载更多特性；
class MyReposWidget extends StatefulWidget{
  final perPageRows = 30;
  final needLoadMore;
  MyReposWidget({Key key, this.needLoadMore=true,}): super(key: key);
  @override
  _MyReposWidgetState createState() => _MyReposWidgetState();
}

class _MyReposWidgetState extends State<MyReposWidget> {
  final List<RepoEntity> repos = [];
  int page = 1;
  bool isLoading = false;
  bool expectHasMoreData = true;
  @override
  void initState() {
    super.initState();
    loadRepos(true);
  }
  Future loadRepos(bool isReload) async {
    if(isLoading) return null;
    isLoading = true;
    int expectationPage;
    if (isReload) {
      expectationPage = 1;
    } else {
      expectationPage = page + 1;
    }
    return ApiService.getRepos(page: expectationPage).then<bool>((list) {
      setState(() {
        if (isReload) { //初始加载或下拉刷新数据
          this.repos
            ..clear()
            ..addAll(list);
          page = 1;
        } else { //上拉加载更多数据
          if(list.isNotEmpty) {
            this.repos.addAll(list);
            ++page;
          }
        }
        //判断是否还有更多数据
        this.expectHasMoreData = list.length >= widget.perPageRows;
        this.isLoading = false;
      });
      return;
    }).catchError((e) {
      this.isLoading = false;
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
            if(widget.needLoadMore && expectHasMoreData) { //是否需要实现加载更多特性
              if(0 == notification.metrics.extentAfter) { //到达底部
                loadRepos(false);
              }
            }
            return false; //返回false，将事件传递给外层控件(RefreshIndicator)，否则外层RefreshIndicator无法监听到下拉手势
          },
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(height: 4, color: Theme.of(context).primaryColor,);
            },
            padding: EdgeInsets.all(0.0),
            itemCount: (repos.length >= widget.perPageRows && widget.needLoadMore) ? repos.length+1 : repos.length,
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
                return LoadMoreDataFooter(expectHasMoreData);
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