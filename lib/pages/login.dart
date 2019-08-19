import 'package:flutter/material.dart';
import 'package:githao/biz/user_biz.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/provide/user_provide.dart';
import 'package:githao/utils/util.dart';
import 'package:provide/provide.dart';
import 'dart:convert';
import 'package:githao/widgets/login_wave_clippers.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  static const ROUTE_NAME = "/login";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _loginFormKey = new GlobalKey();
  FocusNode passwordFocusNode, loginFocusNode;
  bool isShowPassWord = false;
  String username = '';
  String password = '';
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    passwordFocusNode = FocusNode();
    loginFocusNode = FocusNode();
  }
  /// 点击控制密码是否显示
  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  void doLogin() {
    _loginFormKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    //登录前，先移除之前保存的登录信息。
    UserBiz.logout().then<UserEntity>((_) {
      return UserBiz.login(username, password);
    }).then((userEntity) async {
      if(userEntity != null ) {
        Provide.value<UserProvide>(context).updateUser(userEntity);
        Navigator.of(context).pushReplacementNamed(HomePage.ROUTE_NAME);
      } else {
        throw Exception("获取用户信息出错！");
      }
    }).catchError((e) {
      Util.showToast('登录失败：${e.toString()}');
    });
  }

  getCurrentUser() async {
    UserEntity user = await UserBiz.getUser();
    Util.showToast('user.html_url = ${user.htmlUrl}');
  }

  String getCredentialsBasic(String username, String password) {
    final bytes = latin1.encode("$username:$password");
    final encoded = base64Encode(bytes);
    return "Basic " + encoded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipper2(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Theme.of(context).primaryColorDark.withOpacity(0.3), Theme.of(context).primaryColorLight.withOpacity(0.3)])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper3(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Theme.of(context).primaryColorDark.withOpacity(0.6), Theme.of(context).primaryColorLight.withOpacity(0.6)])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper1(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Icon(
                        Icons.developer_mode,
                        color: Colors.white,
                        size: 60,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "GitHao",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 30),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Theme.of(context).primaryColorDark, Theme.of(context).primaryColorLight])),
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          //登录Form
          Form(
            key: _loginFormKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: TextFormField(
                      autofocus: true,
                      //点击完成按钮时，使password输入框自动获得焦点
                      onEditingComplete: () => FocusScope.of(context).requestFocus(passwordFocusNode),
                      validator: (value) {
                        return value.isEmpty ? S.current.thisFieldCanNotBeEmpty : null;
                      },
                      onSaved: (value) {
                        this.username = value;
                      },
                      decoration: InputDecoration(
                          hintText: S.current.loginAccountHint,
                          prefixIcon: Material(
                            elevation: 0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Icon(
                              Icons.account_circle,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13)
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: TextFormField(
                      focusNode: passwordFocusNode,
                      //点击完成按钮时，使login按钮自动获得焦点
                      onEditingComplete: () => FocusScope.of(context).requestFocus(loginFocusNode),
                      validator: (value) {
                        return value.isEmpty ? S.current.thisFieldCanNotBeEmpty : null;
                      },
                      onSaved: (value) {
                        this.password = value;
                      },
                      //输入密码，需要用*****显示
                      obscureText: !isShowPassWord,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(
                                isShowPassWord ? Icons.visibility_off : Icons.visibility,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () => showPassWord()
                          ),
                          hintText: S.current.loginPasswordHint,
                          prefixIcon: Material(
                            elevation: 0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Icon(
                              Icons.lock,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: FlatButton(
              color: Theme.of(context).primaryColor,
              shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              focusNode: loginFocusNode,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Text(
                  S.current.login,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20,),
                ),
              ),
              onPressed: () {
                if(_loginFormKey.currentState.validate()) {
                  doLogin();
                }
              },
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
  @override
  void dispose() {
    passwordFocusNode.dispose();
    loginFocusNode.dispose();
    super.dispose();
  }
}
