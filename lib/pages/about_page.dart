import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:package_info/package_info.dart';

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
                title: Text(_packageInfo?.appName, style: TextStyle(fontSize: 22),),
                subtitle: Text(S.current.copyright),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(S.current.version),
                subtitle: Text(_packageInfo?.version),
              ),
              ListTile(
                leading: Icon(Icons.code),
                title: Text(S.current.sourceCode),
                subtitle: Text(S.current.starToSupportMe),
              ),
              Divider(color: Colors.grey,),
            ],
          ),
        ),
      ),
    );
  }
}