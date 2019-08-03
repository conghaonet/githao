import 'dart:async';

import 'package:flutter/material.dart';
import 'package:githao/biz/user_biz.dart';
import 'package:githao/network/entity/user_entity.dart';

import 'home.dart';
import 'login.dart';
import 'package:githao/generated/i18n.dart';

class SplashPage extends StatefulWidget {
  static const ROUTE_NAME = "/splash";
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const ANIMATION_SECONDS = 3;
  bool isShown = false;
  Timer timer;
  /// 验证用户是否已登录
  Future hasLogin() async {
    UserEntity userEntity = await UserBiz.getUser();
    if (userEntity != null) {
      Navigator.of(context).pushReplacementNamed(HomePage.ROUTE_NAME);
    } else {
      Navigator.of(context).pushReplacementNamed(LoginPage.ROUTE_NAME);
    }
  }
  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: ANIMATION_SECONDS + 1), () {
      hasLogin();
    });
    //界面渲染第一帧时的监听，仅监听一次。
    WidgetsBinding.instance.addPostFrameCallback((_){
      print("Frame has been rendered");
      setState(() {
        isShown = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: AnimatedDefaultTextStyle(
                child: Text(
                  S.of(context).appTitle,
                ),
                style: isShown
                    ? TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColorDark)
                    : TextStyle(
                        fontFamily: 'AGENCYR',
                        fontSize: 36,
                        fontWeight: FontWeight.w200,
                        color: Colors.blue,),
                duration: const Duration(seconds: ANIMATION_SECONDS),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FlatButton(
                child: Text(
                  S.of(context).skip,
                  style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.w800),
                ),
                onPressed:() {
                  hasLogin();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}