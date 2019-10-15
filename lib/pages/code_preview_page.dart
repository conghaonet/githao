import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/routes/code_preview_page_args.dart';
import 'package:githao/utils/util.dart';

import 'code_preview_html.dart';

class CodePreviewPage extends StatefulWidget {
  static const ROUTE_NAME = '/code_preivew';
  final CodePreviewPageArgs args;
  CodePreviewPage(this.args, {Key key}): super(key: key);
  @override
  _CodePreviewPageState createState() => _CodePreviewPageState();
}

class _CodePreviewPageState extends State<CodePreviewPage> {
  String _title;
  String _fileSuffix;
  String _rawContent;
  Syntax _syntax;
  @override
  void initState() {
    super.initState();
    _title = widget.args.contentPath.substring(widget.args.contentPath.lastIndexOf('/')+1, widget.args.contentPath.length);
    if(_title.lastIndexOf('.') != -1 && (_title.lastIndexOf('.') + 1) != _title.length) {
      _fileSuffix = _title.substring(_title.lastIndexOf('.')+1, _title.length).toLowerCase();
    }
    if(_fileSuffix == 'java') {
      _syntax = Syntax.JAVA;
    } else if(_fileSuffix == 'dart') {
      _syntax = Syntax.DART;
    } else if(_fileSuffix == 'kt') {
      _syntax = Syntax.KOTLIN;
    } else if(_fileSuffix == 'js') {
      _syntax = Syntax.JAVASCRIPT;
    } else if(_fileSuffix == 'swift') {
      _syntax = Syntax.SWIFT;
    }
    if(_syntax != null) {
      ApiService.getRepoContentRaw(
        widget.args.repoEntity.owner.login,
        widget.args.repoEntity.name,
        widget.args.branch,
        widget.args.contentPath,).then((result) {
        _rawContent = result;
        if(mounted) { setState(() {}); }
      },
      ).catchError((e){
        Util.showToast(e.toString());
      });
    }
    //界面渲染第一帧时的监听，仅监听一次。
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(_syntax == null) {
        if(mounted) {
          Navigator.pushReplacementNamed(context, CodePreviewHtmlPage.ROUTE_NAME, arguments: widget.args);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_syntax == null) {
      return Container();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Container(
          child: SyntaxView(
          code: _rawContent ?? '',
          syntax: _syntax,
          syntaxTheme: SyntaxTheme.dracula(),
          withZoom: true,
          withLinesCount: true,
        ),
        ),
      );
    }
  }
  @override
  void dispose() {
    super.dispose();
  }
}