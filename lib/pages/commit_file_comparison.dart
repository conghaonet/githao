import 'package:flutter/material.dart';
import 'package:githao/network/entity/commit_detail_entity.dart';

class CommitFileComparisonPage extends StatelessWidget {
  static const String ROUTE_NAME = '/commit_file_comparison';
  static const String CODE_FONT = 'cour';
  static final String _numLeftSpaces = '  ';
  static final String _numRightSpaces = '  ';
  static final Color headerBackgroundColor = Colors.grey.withOpacity(0.5);
  static final Color addBackgroundColor = Colors.green.withOpacity(0.5);
  static final Color reduceBackgroundColor = Colors.red.withOpacity(0.5);
  final CommitDetailFile file;

  CommitFileComparisonPage(this.file, {Key key}): super(key: key);

  /// 获取文件需要显示的最大行编号，用于计算每行的长度，使行号对齐显示
  int _getMaxLineNum(List<String> lines) {
    for(int i= lines.length-1; i>=0; i--) {
      if(lines[i].startsWith('@@ -')) {
        PartInfo partInfo = PartInfo(rowIndex: i, row: lines[i]);
        return partInfo.addEndRowNum > partInfo.reduceEndRowNum ? partInfo.addEndRowNum : partInfo.reduceEndRowNum;
      }
    }
    return 0;
  }

  /// 获取文件中最长一行的长度，用于渲染背景
  int _getMaxLineLength(List<String> lines) {
    int maxLength = 0;
    for(int i= lines.length-1; i>=0; i--) {
      if(lines[i].length > maxLength) {
        maxLength = lines[i].length;
      }
    }
    return maxLength;
  }

  /// 用于渲染每行代码
  List<InlineSpan> _buildLinesView() {
    List<String> lines;
    int maxLineNumLength;
    List<InlineSpan> spans = [];

    lines = file.patch.split('\n');
//    lines.removeWhere((line) => line == gitHubTail);
    maxLineNumLength = _getMaxLineNum(lines).toString().length + _numLeftSpaces.length;
    int uiMaxLineLength = _getMaxLineLength(lines) + maxLineNumLength *2 + _numRightSpaces.length * 2;
    PartInfo lastPartInfo;
    int lastReduceIndex;
    int lastAddIndex;
    for(int i=0; i<lines.length; i++) {
      TextSpan lineSpan;
      if(lines[i].startsWith('@@ -')) {
        lastPartInfo = PartInfo(rowIndex: i, row: lines[i]);
        lastReduceIndex = 0;
        lastAddIndex = 0;
        lineSpan = TextSpan(
          text: '$_numLeftSpaces${lines[i]}'.padRight(uiMaxLineLength, ' ')+'\n',
          style: TextStyle(backgroundColor: headerBackgroundColor, fontFamily: CODE_FONT,),
        );
      } else {
        if(lines[i].startsWith('-')) { // 删除的代码行
          String strReduceNum = (lastReduceIndex + lastPartInfo.reduceBeginRowNum).toString().padLeft(maxLineNumLength, ' ');
          String strAddNum = ''.padLeft(maxLineNumLength, ' ');
          lineSpan = TextSpan(
            text: '$strReduceNum$strAddNum$_numRightSpaces${lines[i]}'.padRight(uiMaxLineLength, ' ')+'\n',
            style: TextStyle(backgroundColor: reduceBackgroundColor, fontFamily: CODE_FONT,),
          );
          ++lastReduceIndex;
        } else if(lines[i].startsWith('+')) { // 新增代码行
          String strReduceNum = ''.padLeft(maxLineNumLength, ' ');
          String strAddNum = (lastAddIndex + lastPartInfo.addBeginRowNum).toString().padLeft(maxLineNumLength, ' ');
          lineSpan = TextSpan(
            text: '$strReduceNum$strAddNum$_numRightSpaces${lines[i]}'.padRight(uiMaxLineLength, ' ')+'\n',
            style: TextStyle(backgroundColor: addBackgroundColor, fontFamily: CODE_FONT,),
          );
          ++lastAddIndex;
        } else { // 未修改的代码行
          String strReduceNum;
          if(lastReduceIndex < lastPartInfo.reduceEndRowNum) {
            strReduceNum = (lastReduceIndex + lastPartInfo.reduceBeginRowNum).toString().padLeft(maxLineNumLength, ' ');
          } else {
            continue;
          }
          String strAddNum;
          if(lastAddIndex < lastPartInfo.addEndRowNum) {
            strAddNum = (lastAddIndex + lastPartInfo.addBeginRowNum).toString().padLeft(maxLineNumLength, ' ');
          } else {
            continue;
          }
          lineSpan = TextSpan(
            text: '$strReduceNum$strAddNum$_numRightSpaces${lines[i]}'.padRight(uiMaxLineLength, ' ')+'\n',
            style: TextStyle(fontFamily: CODE_FONT,),
          );
          ++lastReduceIndex;
          ++lastAddIndex;
        }
      }
      spans.add(lineSpan);
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    String _title = file.filename;
    if(file.filename.contains('/')) {
      _title = file.filename.substring(file.filename.lastIndexOf('/')+1, file.filename.length);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xff2b2b2b),
        child: Scrollbar(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: file.changes == 0
                      ? Container()
                      : Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 18.0, color: Colors.white,),
                        text: '',
                        children: _buildLinesView(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PartInfo {
  final int rowIndex;
  final String row;
  int _reduceBeginRowNum;
  int _reduceEndRowNum;
  int _addBeginRowNum;
  int _addEndRowNum;
  PartInfo({this.rowIndex, this.row}) {
    List<String> modifyNumArr = row.split('@@')[1].trim().split(' ');

    List<String> reduceNumRange = modifyNumArr[0].split(',');
    this._reduceBeginRowNum = int.parse(reduceNumRange[0].substring(1));
    if(reduceNumRange.length == 1) {
      this._reduceEndRowNum = 1;
    } else if(reduceNumRange.length == 2) {
      this._reduceEndRowNum = this._reduceBeginRowNum + int.parse(reduceNumRange[1]) - 1;
    }


    List<String> addNumRange = modifyNumArr[1].split(',');
    this._addBeginRowNum = int.parse(addNumRange[0].substring(1));
    if(addNumRange.length == 1) {
      this._addEndRowNum = 1;
    } else if(addNumRange.length == 2) {
      this._addEndRowNum = this._addBeginRowNum + int.parse(addNumRange[1]) - 1;
    }
  }

  int get reduceBeginRowNum => _reduceBeginRowNum;
  int get reduceEndRowNum => _reduceEndRowNum;
  int get addBeginRowNum => _addBeginRowNum;
  int get addEndRowNum => _addEndRowNum;
}