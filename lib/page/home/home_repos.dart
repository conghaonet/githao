
import 'package:flutter/material.dart';
import 'package:githao/generated/l10n.dart';

class HomeRepos extends StatefulWidget {
  const HomeRepos({Key? key}) : super(key: key);

  @override
  _HomeReposState createState() => _HomeReposState();
}

class _HomeReposState extends State<HomeRepos> {
  late DateTime _dateTime;
  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(_dateTime.toIso8601String()),
      ),
    );
  }
}
