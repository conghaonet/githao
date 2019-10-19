import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/pages/profile_page.dart';
import 'package:githao/pages/repo_home_page.dart';
import 'package:githao/routes/profile_page_args.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  static const ROUTE_NAME = '/about_page';
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  PackageInfo _packageInfo;

  @override
  void initState() {
    super.initState();
    _refreshPackageInfo();
  }

  void _refreshPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    if(mounted) {
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.about),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset('images/ic_launcher.png',
                    ),
                  ),
                  backgroundColor: Color(0X00ffffff),
                ),
                title: Text(_packageInfo?.appName ?? '', style: TextStyle(fontSize: 22),),
                subtitle: Text(S.current.copyright),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(S.current.version),
                subtitle: Text(_packageInfo?.version ?? ''),
              ),
              ListTile(
                leading: Icon(Icons.code),
                title: Text(S.current.sourceCode),
                subtitle: Text(S.current.starToSupportMe),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, RepoHomePage.ROUTE_NAME, arguments: S.current.appRepoFullName);
                },
              ),
              Divider(color: Colors.grey,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8,),
                child: Text(S.current.author, style: TextStyle(fontSize: 20),),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(S.current.authorName),
                subtitle: Text(S.current.authorLocation),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, ProfilePage.ROUTE_NAME,
                    arguments: ProfilePageArgs(login: S.current.authorGithubLogin, heroTag: 'about_author_conghaonet'),);
                },
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(S.current.email),
                subtitle: Text(S.current.authorEmail),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  launch('mailto:${S.current.authorEmail}');
                },
              ),
              Divider(color: Colors.grey,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8,),
                child: Text(S.current.share, style: TextStyle(fontSize: 20),),
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text(S.current.shareToYourFriends),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Share.share(S.current.shareText, subject: _packageInfo?.appName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}