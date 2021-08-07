import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:githao/app_manager.dart';
import 'package:githao/generated/l10n.dart';
import 'package:githao/util/const.dart';
import 'package:githao/util/prefs_manager.dart';
import 'package:githao/widget/flutter_logo_animation.dart';
import 'package:githao/util/string_extension.dart';

import 'app_route.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  int stackIndex = 0;
  @override
  void initState() {
    super.initState();
    Future(() async {
      await appManager.init();
      validateUser();
    });
  }
  void validateUser() {
    if(prefsManager.getToken().isNullOrEmpty()) {
      setState(() {
        stackIndex = 1;
      });
    } else {
      Navigator.pushNamed(context, AppRoute.routeHome);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Container(),),
              Text(S.of(context).app_name,
                style: TextStyle(fontFamily: Const.font1, fontSize: 48, fontWeight: FontWeight.w900),
              ),
              Text(S.of(context).app_desc,
                style: TextStyle(fontFamily: Const.font1),
              ),
              Expanded(child: Container(),),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/github.webp'),
                  const FlutterLogoAnimation(),
                ],
              ),
              Expanded(child: Container(),),
              IndexedStack(
                index: this.stackIndex,
                alignment: AlignmentDirectional.center,
                children: [
                  CircularProgressIndicator(),
                  CupertinoButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ImageIcon(AssetImage('assets/images/github.webp'),),
                        const Padding(padding: EdgeInsets.all(8)),
                        Text(S.of(context).sing_in_with_github,)
                      ],
                    ),
                  ),
                ]
              ),
              Expanded(child: Container(),),
            ],
          )
      ),
    );
  }
}
