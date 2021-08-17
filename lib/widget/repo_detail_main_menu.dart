import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:githao/generated/l10n.dart';
import 'package:githao/network/entity/repo/repo_entity.dart';
import 'package:githao/network/github_service.dart';
import 'package:githao/util/util.dart';
import 'package:githao/util/string_extension.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RepoDetailMainMenu extends StatefulWidget {
  final RepoEntity repo;
  const RepoDetailMainMenu(this.repo, {Key? key}) : super(key: key);

  @override
  _RepoDetailMainMenuState createState() => _RepoDetailMainMenuState();
}

class _RepoDetailMainMenuState extends State<RepoDetailMainMenu> {
  String? _readmeRaw;
  @override
  void initState() {
    super.initState();
    loadReadme();
  }

  Future<void> loadReadme() async {
    // _readmeRaw = '<html><body>Hello world!</body></html>';
    var httpResponse = await githubService.getRepoContentHtml('conghaonet', 'GitHao', 'README.md', 'master');
    _readmeRaw = httpResponse.response.data;
    _readmeRaw ="data:text/html;charset=utf-8;base64,${base64Encode(const Utf8Encoder().convert(_readmeRaw!))}";

    // var entity = await githubService.getRepoContent('conghaonet', 'GitHao', 'README.md', 'master');
    // var content = entity.content!.replaceAll('\n', '');
    // Uint8List uint8List = base64Decode(content);
    // _readmeRaw = utf8.decode(uint8List);
    setState(() {

    });
    // print(_readmeRaw);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Divider(height: 0.5, thickness: 0.5,),
        ListTile(
          leading: ImageIcon(getSvgProvider('assets/github/issue-opened-16.svg'), color: Colors.green,),
          title: Row(
            children: [
              Expanded(child: Text(S.of(context).issues)),
              Text('${widget.repo.openIssuesCount ?? 0}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {

          },
        ),
        Divider(height: 0.5, thickness: 0.5,),
        ListTile(
          leading: ImageIcon(getSvgProvider('assets/github/git-pull-request-16.svg'), color: Colors.blue,),
          title: Text(S.of(context).pull_requests),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {

          },
        ),
        Divider(height: 0.5, thickness: 0.5,),
        ListTile(
          leading: ImageIcon(getSvgProvider('assets/github/eye-16.svg'), color: Colors.yellow,),
          title: Row(
            children: [
              Expanded(child: Text(S.of(context).watchers)),
              Text('${widget.repo.subscribersCount ?? 0}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          trailing: widget.repo.subscribersCount == 0 ? null : Icon(Icons.keyboard_arrow_right),
          onTap: widget.repo.subscribersCount == 0 ? null : () {

          },
        ),
        Divider(height: 0.5, thickness: 0.5,),
        ListTile(
          leading: ImageIcon(getSvgProvider('assets/github/law-16.svg'), color: Colors.red),
          title: Row(
            children: [
              Expanded(child: Text(S.of(context).license)),
              Text(widget.repo.license != null ? widget.repo.license!.spdxId! : S.of(context).none,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          trailing: widget.repo.license != null ? Icon(Icons.keyboard_arrow_right) : null,
          onTap: widget.repo.license == null ? null : () {

          },
        ),
        Divider(height: 0.5, thickness: 0.5,),
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 8, left: 16, right: 16,),
          child: Row(
            children: [
              ImageIcon(getSvgProvider('assets/github/git-branch-16.svg'), color: Colors.grey,),
              Expanded(child: Text(widget.repo.defaultBranch.nullSafety, style: TextStyle(color: Colors.grey),),),
              InkWell(
                child: Text(S.of(context).change, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
              ),
            ],
          ),
        ),
        Divider(height: 0.5, thickness: 0.5,),
        ListTile(
          leading: ImageIcon(getSvgProvider('assets/github/code-16.svg'),),
          title: Text(S.of(context).browse_code),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {

          },
        ),
        Divider(height: 0.5, thickness: 0.5,),
        ListTile(
          leading: ImageIcon(getSvgProvider('assets/github/commit-24.svg'),),
          title: Text(S.of(context).commits),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {

          },
        ),
        Divider(height: 0.5, thickness: 0.5,),
        if(!_readmeRaw.isNullOrEmpty)
        Container(
          width: double.infinity,
          height: 1500,
          child: WebView(
            //https://raw.githubusercontent.com/conghaonet/GitHao/master/README.md
            // initialUrl: 'https://raw.githubusercontent.com/${widget.repo.fullName}/${widget.repo.defaultBranch}/README.md',
            initialUrl: _readmeRaw ?? '',
            javascriptMode: JavascriptMode.unrestricted,

          ),
        )
        // if(!_readmeRaw.isNullOrEmpty)
          // SizedBox(
          //   width: double.infinity,
          //   height: 1200,
          //   child: Markdown(
          //     data: _readmeRaw!,
          //     selectable: true,
          //   ),
          // ),
      ],
    );
  }
}
