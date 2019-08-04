import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/utils/util.dart';

class MyReposWidget extends StatefulWidget{
  final bool shrinkWrap;
  final bool primary;

  MyReposWidget({Key key, this.shrinkWrap = false, this.primary = true}): super(key: key);
  @override
  _MyReposWidgetState createState() => _MyReposWidgetState();
}

class _MyReposWidgetState extends State<MyReposWidget> {
  final List<RepoEntity> repos = [];
  @override
  void initState() {
    super.initState();
    loadRepos();
  }

  Future<bool> loadRepos() async {
    return ApiService.getRepos().then<bool>((repos){
      setState(() {
        this.repos..clear()..addAll(repos);
      });
      return true;
    }).catchError((e) {
      Util.showToast(e.toString());
      return true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        color: Colors.blue,
        onRefresh: () async {
          return await loadRepos();
        },
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(height: 4, color: Theme.of(context).primaryColor,);
          },
          padding: EdgeInsets.all(0.0),
          shrinkWrap: widget.shrinkWrap,
          primary: widget.primary,
          itemCount: repos.length,
          itemBuilder: (context, index) {
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
//          return Container(
//            alignment: Alignment.center,
//            color: Colors.lightGreen[100 * (index % 9)],
//            child: Text('list item $index'),
//          );
          },
        ),
      ),
    );
  }
}