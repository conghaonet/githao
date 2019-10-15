import 'package:flutter/material.dart';
import 'package:githao/biz/user_biz.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/provide/user_provide.dart';
import 'package:githao/utils/util.dart';
import 'package:provide/provide.dart';
import 'package:githao/widgets/login_wave_clippers.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  static const ROUTE_NAME = "/login";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _loginFormKey = new GlobalKey();
  FocusNode _passwordFocusNode, _loginFocusNode;
  bool _isShowPassWord = false;
  String _username = '';
  String _password = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _loginFocusNode = FocusNode();
  }

  /// 点击控制密码是否显示
  void _showPassWord() {
    setState(() {
      _isShowPassWord = !_isShowPassWord;
    });
  }

  void _doLogin() {
    _loginFormKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    //登录前，先移除之前保存的登录信息。
    UserBiz.logout().then<UserEntity>((_) {
      return UserBiz.login(_username, _password);
    }).then((userEntity) async {
      if(userEntity != null ) {
        Provide.value<UserProvide>(context).updateUser(userEntity);
        Navigator.of(context).pushReplacementNamed(HomePage.ROUTE_NAME);
      } else {
        throw Exception("获取用户信息出错！");
      }
    }).catchError((e) {
      Util.showToast('登录失败：${e.toString()}');
    }).whenComplete(() {
      if(mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
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
                      onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordFocusNode),
                      validator: (value) {
                        return value.isEmpty ? S.current.thisFieldCanNotBeEmpty : null;
                      },
                      onSaved: (value) {
                        this._username = value;
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
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: TextFormField(
                      focusNode: _passwordFocusNode,
                      //点击完成按钮时，使login按钮自动获得焦点
                      onEditingComplete: () => FocusScope.of(context).requestFocus(_loginFocusNode),
                      validator: (value) {
                        return value.isEmpty ? S.current.thisFieldCanNotBeEmpty : null;
                      },
                      onSaved: (value) {
                        this._password = value;
                      },
                      //输入密码，需要用*****显示
                      obscureText: !_isShowPassWord,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(
                                _isShowPassWord ? Icons.visibility_off : Icons.visibility,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () => _showPassWord()
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
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          //登录按钮及Loading的切换动画
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation,);
            },
            child: _isLoading ? _buildLoginLoading() : _buildLoginButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginLoading() {
    return CircularProgressIndicator();
  }
  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: FlatButton(
          color: Theme.of(context).primaryColor,
          shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          focusNode: _loginFocusNode,
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Text(
              S.current.login,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20,),
            ),
          ),
          onPressed: () {
            if(_loginFormKey.currentState.validate()) {
              _doLogin();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _loginFocusNode.dispose();
    super.dispose();
  }
}
