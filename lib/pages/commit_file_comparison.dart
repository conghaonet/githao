import 'package:flutter/material.dart';
import 'package:githao/network/entity/commit_detail_entity.dart';
import 'dart:math';

class CommitFileComparisonPage extends StatelessWidget {
  static const ROUTE_NAME = '/commit_file_comparison';
  final CommitDetailFile file;
  CommitFileComparisonPage(this.file, {Key key}): super(key: key);

  int getMaxLineNum(List<String> lines) {
    for(int i= lines.length-1; i>=0; i--) {
      if(lines[i].startsWith('@@ -')) {
        String tag = lines[i].split('@@')[1].trim();
        List<String> modifyNumArr = tag.split(' ');
        int reduceStartLine = int.parse((modifyNumArr[0].split(',')[0]).substring(1));
        int maxReduceLineNum = reduceStartLine + int.parse(modifyNumArr[0].split(',')[1]) - 1;

        int addStartLine = int.parse((modifyNumArr[1].split(',')[0]).substring(1));
        int maxAddLineNum = addStartLine + int.parse(modifyNumArr[1].split(',')[1]) - 1;

        return maxAddLineNum > maxReduceLineNum ? maxAddLineNum : maxReduceLineNum;

      }
    }
    return 0;
  }
  
  @override
  Widget build(BuildContext context) {
    String _title = file.filename;
    if(file.filename.contains('/')) {
      _title = file.filename.substring(file.filename.lastIndexOf('/')+1, file.filename.length);
    }
    
    List<String> lines = file.patch.split('\n');
    int maxLineNum = getMaxLineNum(lines);


    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: RichText(
              softWrap: false,
              overflow: TextOverflow.visible,
              textWidthBasis: TextWidthBasis.longestLine,
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                text: file.patch,
              ),
            ),
          ),
        ),
      ),
    );
  }

}