import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/routes/code_preview_page_args.dart';
import 'package:githao/utils/util.dart';

class CodePreviewPage extends StatefulWidget {
  static const ROUTE_NAME = '/code_preivew';
//  final String contentPath;
//  final RepoEntity repoEntity;
//  final String branch;
  final CodePreviewPageArgs args;
  CodePreviewPage(this.args, {Key key}): super(key: key);


  @override
  _CodePreviewPageState createState() => _CodePreviewPageState();
}

class _CodePreviewPageState extends State<CodePreviewPage> {
  String rawContent;
  @override
  void initState() {
    super.initState();
    ApiService.getRepoContentRaw(
      widget.args.repoEntity.owner.login,
      widget.args.repoEntity.name,
      widget.args.branch,
      widget.args.contentPath,).then((result) {
        rawContent = result;
        if(mounted) { setState(() {}); }
      },
    ).catchError((e){
      Util.showToast(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args.contentPath.substring(widget.args.contentPath.lastIndexOf('/')+1, widget.args.contentPath.length)),
      ),
      body: Container(
        child: _getContentView(),
      ),
    );
  }

  Widget _getContentView() {
    return SyntaxView(
      code: rawContent ?? '',
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.dracula(),
      withZoom: true,
      withLinesCount: true,
    );
  }

  @override
  void dispose() {

    super.dispose();
  }
}