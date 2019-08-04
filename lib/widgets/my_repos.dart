import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/utils/util.dart';

class MyRepos extends StatefulWidget{
  final bool shrinkWrap;
  final bool primary;

  MyRepos({Key key, this.shrinkWrap = false, this.primary = true}): super(key: key);
  @override
  _MyReposState createState() => _MyReposState();
}

class _MyReposState extends State<MyRepos> {
  final List<RepoEntity> repos = [];
  @override
  void initState() {
    super.initState();
    loadRepos();
  }

  loadRepos() {
    ApiService.getRepos().then((repos){
      setState(() {
        this.repos..clear()..addAll(repos);
      });
    }).catchError((e) {
      Util.showToast(e.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
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
    );
  }
}