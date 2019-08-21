import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/commit_detail_entity.dart';
import 'package:githao/routes/commit_detail_page_args.dart';
import 'package:githao/utils/util.dart';

/// /repos/conghaonet/GitHao/commits/81a929953bfc2f1cd243e2a3b02d8829f41caec5
///
class CommitDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/commit_detail';
  final CommitDetailPageArgs args;

  CommitDetailPage(this.args, {Key key}): super(key: key);

  @override
  _CommitDetailPageState createState() => _CommitDetailPageState();
}

class _CommitDetailPageState extends State<CommitDetailPage> {
  ScrollController _scrollController = ScrollController();
  Color appBarBackground;
  double topPosition;
  CommitDetailEntity _detailEntity;

  @override
  void initState() {
    topPosition = -80;
    appBarBackground = Colors.transparent;
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadData();
  }

  double _getOpacity() {
    double op = (topPosition + 80) / 80;
    return op > 1 || op < 0 ? 1 : op;
  }

  _onScroll() {
    if (_scrollController.offset > 50) {
      if (topPosition < 0)
        setState(() {
          topPosition = -130 + _scrollController.offset;
          if (_scrollController.offset > 130) topPosition = 0;
        });
    } else {
      if (topPosition > -80)
        setState(() {
          topPosition--;
          if (_scrollController.offset <= 0) topPosition = -80;
        });
    }
  }
  
  void _loadData() {
    //TODO: for debug
    String sha = '81a929953bfc2f1cd243e2a3b02d8829f41caec5';
    ApiService.getCommitDetail(widget.args.repoEntity.owner.login, widget.args.repoEntity.name, sha).then((result) {
      _detailEntity = result;
      _detailEntity.files.sort((fileA, fileB) {
        return fileA.filename.compareTo(fileB.filename);
      });
      _detailEntity.files.sort((fileA, fileB) {
        if(fileA.filename.contains('/') && !fileB.filename.contains('/')) {
          return 1;
        } else if(!fileA.filename.contains('/') && fileB.filename.contains('/')) {
          return -1;
        } else {
          return 0;
        }
      });

    }).catchError((e) {
      Util.showToast(e.toString());
    }).whenComplete(() {
      if(mounted) { setState(() {}); }
    });
  }

  List<Widget> _buildFiles() {
    List<Widget> files = [];
    String lastPath = '';
    if(_detailEntity != null && _detailEntity.files.isNotEmpty) {
      for(int i=0; i<_detailEntity.files.length; i++) {
        String path = '';
        if(_detailEntity.files[i].filename.contains('/')) {
          path = _detailEntity.files[i].filename.substring(0, _detailEntity.files[i].filename.lastIndexOf('/')+1);
        }

        var file = Row(
          children: <Widget>[
            Text(_detailEntity.files[i].filename),
          ],
        );
        files.add(file);
      }
    }
    return files;
  }

  String getTitleString() {
    return '${S.current.commit} ${widget.args.sha.substring(0, 7)}';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 50.0, right: 50),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0)),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 70),
                      Text(
                        getTitleString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                            _detailEntity == null ? '' :
                            '${S.current.committed} ${Util.getFriendlyDateTime(_detailEntity.commit.committer.date)}'
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                            '${S.current.committer}：${widget.args.committer.login ?? widget.args.committer.name}'
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.insert_drive_file),
                          Text(_detailEntity == null ? '' : '${_detailEntity?.files?.length}'),
                          Spacer(),
                          const Icon(Icons.add_box),
                          Text(_detailEntity == null ? '' : '${_detailEntity?.stats?.additions}'),
                          Spacer(),
                          const Icon(Icons.indeterminate_check_box),
                          Text(_detailEntity == null ? '' : '${_detailEntity?.stats?.deletions}'),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 24),
                        child: Text(
                            _detailEntity == null ? '' : '${_detailEntity.commit.message}'
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
              ]..addAll(_buildFiles()),
            ),
          ),
          Positioned(
              top: topPosition,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                padding: const EdgeInsets.only(left: 50,top: 25.0,right: 20.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0)),
                  color: Colors.white.withOpacity(_getOpacity()),
                ),
                child: DefaultTextStyle(
                  style: TextStyle(),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  child: Semantics(
                    child: Text(
                      getTitleString(),
                      style: TextStyle(color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.bold),
                    ),
                    header: true,
                  ),
                ),
              )
          ),
          SizedBox(
            height: 80,
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}