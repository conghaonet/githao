import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.search),
      ),
      body: Container(
        child: Center(
          child: Text('Building...'),
        ),
      ),
    );
  }
}