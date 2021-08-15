import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:githao/generated/l10n.dart';
import 'package:githao/network/entity/repo/repo_entity.dart';
import 'package:githao/network/github_service.dart';
import 'package:githao/util/string_extension.dart';
import 'package:githao/util/util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:githao/util/number_extension.dart';

class RepoDetailPage extends StatefulWidget {
  final RepoDetailPageArgs pageArgs;
  const RepoDetailPage({required this.pageArgs, Key? key}) : super(key: key);
  static RepoDetailPageArgs getPageArgs({required String repoName, required String owner}) {
    return RepoDetailPageArgs(repoName: repoName, owner: owner);
  }

  @override
  _RepoDetailPageState createState() => _RepoDetailPageState();
}

class _RepoDetailPageState extends State<RepoDetailPage> {
  RepoEntity? _repo;
  bool _isStarred = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    _getStarred();
    _repo = await githubService.getRepo(
        owner: widget.pageArgs.owner,
        repoName: widget.pageArgs.repoName
    );
    if(mounted) {
      setState(() {

      });
    }
  }

  void _getStarred() {
    githubService.getStarredRepo(
      widget.pageArgs.owner,
      widget.pageArgs.repoName,
    ).then((httpResponse) {
      _isStarred = httpResponse.response.statusCode == HttpStatus.noContent;
      if(mounted) {
        setState(() {
        });
      }
    }).catchError((e) {
      print(e.toString());
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: IndexedStack(
        index: 0,
        children: [
          if(_repo != null)
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    SizedBox(height: 8,),
                    _buildStarAndWatch(),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: _repo!.owner!.avatarUrl!,
                fit: BoxFit.contain,
                height: 32,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(_repo!.owner!.login!, style: TextStyle(fontSize: 17),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(_repo!.name!, style: TextStyle(fontSize: 20),),
        ),
        if(!_repo!.description.isNullOrEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(_repo!.description.nullSafety),
          ),
        if(!_repo!.homepage.isNullOrEmpty)
          TextButton(
            onPressed: () async {
              if(await canLaunch(_repo!.homepage!)){
                await launch(_repo!.homepage!);
              }
            },
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(getSvgProvider('assets/github/link-16.svg',),),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(_repo!.homepage!, maxLines: 1, overflow: TextOverflow.ellipsis,),
                  ),
                ),
              ],
            ),
          ),
        if(_repo!.private == true)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                ImageIcon(Svg('assets/github/lock-16.svg',), size: 16,),
                SizedBox(width: 8,),
                Text(S.of(context).private),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              ImageIcon(getSvgProvider('assets/github/star-16.svg')),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                child: Text('${_repo!.stargazersCount!.toFriendly()} ${S.of(context).stars}',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              ImageIcon(getSvgProvider('assets/github/repo-forked-16.svg')),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text('${_repo!.forksCount!.toFriendly()} ${S.of(context).forks}',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildStarAndWatch() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(_isStarred) ...[
                  ImageIcon(getSvgProvider('assets/github/star-fill-16.svg'),
                    color: Colors.yellow,
                  ),
                  Text(S.of(context).starred, style: TextStyle(color: Colors.grey),),
                ]
                else ...[
                  ImageIcon(getSvgProvider('assets/github/star-16.svg'),),
                  Text(S.of(context).star,),
                ]
              ],
            ),
            onPressed: () async {
              try {
                var httpResponse = _isStarred ? await githubService.delStarredRepo(
                  _repo!.owner!.login!,
                  _repo!.name!,
                ) : await githubService.starRepo(
                  _repo!.owner!.login!,
                  _repo!.name!,
                );
                if(httpResponse.response.statusCode == HttpStatus.noContent) {
                  if(mounted) {
                    setState(() {
                      _isStarred = !_isStarred;
                    });
                  }
                }
              } catch(e) {
                print(e.toString());
              }
            },
          ),
        ),
        SizedBox(width: 16,),
        Expanded(
          child: OutlinedButton(
            child: Text(S.of(context).watch),
            onPressed: () {

            },
          ),
        ),
      ],
    );
  }
}

class RepoDetailPageArgs {
  final String repoName;
  final String owner;
  RepoDetailPageArgs({
    required this.repoName,
    required this.owner
  });
}
