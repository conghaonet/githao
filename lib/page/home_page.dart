import 'package:flutter/material.dart';
import 'package:githao/generated/l10n.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/util/const.dart';
import 'package:githao/util/prefs_manager.dart';
import 'package:githao/widget/app_logo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserEntity _user;
  @override
  void initState() {
    super.initState();
    _user = prefsManager.getUser()!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      drawer: _buildDrawer(),
      body: Container(
        child: AppLogo(),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLogo(height: 52,),
                  const SizedBox(width: 16,),
                  Text(S.of(context).app_name, style: TextStyle(fontSize: 32, fontFamily: Const.font1),),
                ],
              ),
            ),
            const Divider(thickness: 0.5, height: 0.5,),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
