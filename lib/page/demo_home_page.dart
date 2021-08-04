import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao_v2/util/prefs_manager.dart';
import '/entity/git_hub_api_entity.dart';
import '/network/dio_client.dart';
import '/network/git_hub_service.dart';
import 'web_view_page.dart';
import 'package:oktoast/oktoast.dart';
import 'package:githao_v2/util/string_extension.dart';

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

    } catch (e) {
      print(e);
    }
  }

  void _getUser() {
    final token = prefsManager.getToken();
    if(!token.isNullOrEmpty()) {
      GitHubService(dioClient.dio).getUser().then((value) async {
        showToast(value.login!);
        await prefsManager.setUser(value);
        final userEntity = prefsManager.getUser();
        if(userEntity != null) {
          print('userEntity ====>' + userEntity.toJson().toString());
        }
      }).catchError((exception) {
        showToast(exception.toString());
      });
    }
  }

  void _getOtherUser() async {
    GitHubService(dioClient.dio).getOtherUser('ThirtyDegreesRay').then((value) {
      showToast(value.login!);
    }).catchError((exception) {
      showToast(exception.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Home Page'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              onPressed: () => _getUser(),
              child: Text('_getUser'),
            ),
            ElevatedButton(
              onPressed: () => _getOtherUser(),
              child: Text('_getOtherUser'),
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