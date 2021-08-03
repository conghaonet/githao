import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao_v2/entities/github_api_entity.dart';
import 'package:githao_v2/generated/json/github_api_entity_helper.dart';
import 'package:githao_v2/web_view_page.dart';
import 'package:oktoast/oktoast.dart';

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({Key? key}) : super(key: key);

  @override
  _DemoHomePageState createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  void _tryBaidu() async {
    try {
      var response = await Dio().get('http://baidu.com');
      showToast(response.headers.toString());
      print(response);
    } catch (e) {
      print(e);
    }
  }

  void _tryGithubApi() async {
    try {
      var response = await Dio().get('https://api.github.com');
      if(response.statusCode == HttpStatus.ok) {
        final data = jsonDecode(response.toString());
        final entity = GithubApiEntity();
        githubApiEntityFromJson(entity, data);

        showToast(entity.authorizationsUrl);
        print(response);
      }
    } catch (e) {
      print(e);
    }
  }

  void _tryAuthorize() async {
    final clientId = 'c868cf1dc9c48103bb55';
    final redirectUri = 'http://localhost/oauth/redirect';
    final authorizeUrl = 'https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri';
    try {
      final response = await Dio().get(authorizeUrl);
      print(response.data.toString());
    } catch(e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Demo Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _tryBaidu(),
              child: Text('try baidu'),
            ),
            ElevatedButton(
              onPressed: () => _tryGithubApi(),
              child: Text('_tryGithubApi'),
            ),
            ElevatedButton(
              // onPressed: () => _tryAuthorize(),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WebViewPage())
                );
              },
              child: Text('_tryAuthorize'),
            )

          ],
        ),
      ),
    );
  }
}
