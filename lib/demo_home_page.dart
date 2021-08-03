import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao_v2/entities/git_hub_api_entity.dart';
import 'package:githao_v2/network/dio_client.dart';
import 'package:githao_v2/network/git_hub_service.dart';
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
      var response = await dioClient.dio.get("");
      if(response.statusCode == HttpStatus.ok) {
        final data = jsonDecode(response.toString());
        final entity = GitHubApiEntity.fromJson(data);
        showToast(entity.authorizationsUrl);
        print(response);
      }
    } catch (e) {
      print(e);
    }
  }

  void _tryRetrofit() async {
    try {
      GitHubService(dioClient.dio).getApiMenu().then((value) {
        showToast(value.authorizationsUrl);
      }).catchError((exception){
        showToast(exception.toString());
      });
      
      // var response = await dioClient.dio.get("");
      // if(response.statusCode == HttpStatus.ok) {
      //   final data = jsonDecode(response.toString());
      //   final entity = GitHubApiEntity.fromJson(data);
      //   showToast(entity.authorizationsUrl);
      //   print(response);
      // }
    } catch (e) {
      print(e);
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
              onPressed: () => _tryRetrofit(),
              child: Text('_tryRetrofit'),
            ),
            ElevatedButton(
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
