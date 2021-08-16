import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githao/generated/l10n.dart';
import 'package:githao/network/entity/activity/repo_subscription_entity.dart';
import 'package:githao/network/entity/activity/repo_subscription_queries_entity.dart';
import 'package:githao/network/entity/repo/repo_entity.dart';
import 'package:githao/network/github_service.dart';
import 'package:githao/util/string_extension.dart';
import 'package:githao/util/util.dart';
import 'package:githao/widget/error_view.dart';
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
  final GlobalKey _repoNameKey = GlobalKey();
  final GlobalKey _appBarKey = GlobalKey();
  int _stackIndex = 0;
  RepoEntity? _repo;
  bool _isStarred = false;
  RepoSubscriptionEntity? _subscription;
  RenderObject? _repoNameViewAncestor;
  RenderBox? _repoNameViewRenderBox;
  double? _repoNameViewHeight;
  late StreamController<double> _titleOpacityController;

  @override
  void initState() {
    super.initState();
    _titleOpacityController = StreamController<double>.broadcast();
    _loadData();
  }

  Future<void> _loadData() async {
    _getStarred();
    _getRepoSubscription();
    try {
      _repo = await githubService.getRepo(
          owner: widget.pageArgs.owner,
          repoName: widget.pageArgs.repoName
      );
      _stackIndex = 2;
      if(_repoNameViewHeight == null) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          if(mounted) {
            _repoNameViewAncestor = _appBarKey.currentContext?.findRenderObject();
            _repoNameViewRenderBox = _repoNameKey.currentContext?.findRenderObject() as RenderBox;
            _repoNameViewHeight = _repoNameViewRenderBox?.size.height;
          }
        });
      }
    } catch(e) {
      _stackIndex = 1;
    } finally {
      if(mounted) {
        setState(() {
        });
      }
    }
  }

  void tryAgain() {
    setState(() {
      _stackIndex = 0;
      _loadData();
    });
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

  void _getRepoSubscription() {
    githubService.getRepoSubscription(
      widget.pageArgs.owner,
      widget.pageArgs.repoName,
    ).then((entity) {
      if(mounted) {
        setState(() {
          _subscription = entity;
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
        title: StreamBuilder<double>(
          stream: _titleOpacityController.stream,
          initialData: 0.0,
          builder: (context, snapshot) {
            return Opacity(
              opacity: snapshot.data ?? 0.0,
              child: Text(widget.pageArgs.repoName, style: TextStyle(fontSize: 14),),
            );
          },
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        key: _appBarKey,
        index: _stackIndex,
        children: [
          Center(child: CupertinoActivityIndicator(radius: 16,),),
          Center(child: ErrorView(callback: tryAgain,)),
          if(_repo != null)
            RefreshIndicator(
              onRefresh: _loadData,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if(_repoNameViewHeight != null) {
                    final offsetY = _repoNameViewRenderBox?.localToGlobal(Offset.zero, ancestor: _repoNameViewAncestor).dy;
                    if(offsetY != null) {
                      if(offsetY >= 0 ) {
                        _titleOpacityController.add(0);
                      } else {
                        if(offsetY.abs() >= _repoNameViewHeight!) {
                          _titleOpacityController.add(1);
                        } else {
                          _titleOpacityController.add(offsetY.abs() / _repoNameViewHeight!);
                        }
                      }
                    }
                  }
                  return false;
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _buildHeader(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                          child: _buildStarAndWatch(),
                        ),
                        _buildMenu(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Theme(
      data: ThemeData(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.grey),
      ),
      child: Column(
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
            child: Text(_repo!.name!,
              key: _repoNameKey,
              style: TextStyle(fontSize: 20),
            ),
          ),
          if(!_repo!.description.isNullOrEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(_repo!.description.nullSafety),
            ),
          if(!_repo!.homepage.isNullOrEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  ImageIcon(getSvgProvider('assets/github/link-16.svg',),),
                  Flexible(
                    child: InkWell(
                      onTap: () async {
                        if(await canLaunch(_repo!.homepage!)){
                          await launch(_repo!.homepage!);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(_repo!.homepage!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if(_repo!.fork == true)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageIcon(getSvgProvider('assets/github/repo-forked-16.svg')),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(S.of(context).forked_from, style: TextStyle(fontSize: 14, color: Colors.grey),),
                  ),
                  Flexible(
                    child: InkWell(
                      onTap: () {
                      },
                      child: Text(_repo!.source!.fullName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14),
                      ),
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
                  ImageIcon(getSvgProvider('assets/github/lock-16.svg',),),
                  SizedBox(width: 8,),
                  Text(S.of(context).private, style: TextStyle(fontSize: 14, color: Colors.grey,),),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                ImageIcon(getSvgProvider('assets/github/star-16.svg'),),
                InkWell(
                  onTap: (_repo?.stargazersCount ?? 0) <= 0 ? null : () {

                  },
                  child: Text('${_repo!.stargazersCount!.toFriendly()} ${S.of(context).stars}',
                    style: TextStyle(fontSize: 14,
                      color: (_repo?.stargazersCount ?? 0) <= 0 ? Colors.grey : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(width: 12,),
                ImageIcon(getSvgProvider('assets/github/repo-forked-16.svg'),),
                InkWell(
                  onTap: (_repo?.forksCount ?? 0) <= 0 ? null : () {

                  },
                  child: Text('${_repo!.forksCount!.toFriendly()} ${S.of(context).forks}',
                    style: TextStyle(fontSize: 14,
                      color: (_repo?.forksCount ?? 0) <= 0 ? Colors.grey : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(_subscription?.subscribed == true) ...[
                  ImageIcon(getSvgProvider('assets/github/eye-16.svg'), color: Colors.red,),
                  Text(S.of(context).watching, style: TextStyle(color: Colors.grey),),
                  Icon(Icons.arrow_drop_down, color: Colors.grey,),
                ]
                else if(_subscription?.ignored == true) ...[
                  ImageIcon(getSvgProvider('assets/github/bell-slash-16.svg'),),
                  Text(S.of(context).ignore, style: TextStyle(color: Colors.grey),),
                  Icon(Icons.arrow_drop_down, color: Colors.grey,),
                ]
                else ...[
                  ImageIcon(getSvgProvider('assets/github/eye-16.svg'),),
                  Text(S.of(context).watch,),
                    Icon(Icons.arrow_drop_down,),
                ],
              ],
            ),
            onPressed: () {
              showModalBottomSheet(context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16),),
                ),
                builder: (context) {
                  return _buildBottomWatchMenu();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomWatchMenu() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(S.of(context).close, style: TextStyle(color: Colors.transparent),),
              ),
              Expanded(child: Center(child: Text(S.of(context).notifications))),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(S.of(context).close,),
              ),
            ],
          ),
          Divider(height: 0.5, thickness: 0.5,),
          ListTile(
            title: Text(S.of(context).participating_and_mentions),
            subtitle: Text(S.of(context).msg_repo_no_watch),
            trailing: Icon(Icons.check, color: _subscription == null ? null : Colors.transparent,),
            onTap: () {
              githubService.delRepoSubscription(widget.pageArgs.owner, widget.pageArgs.repoName).then((httpResponse) {
                if(httpResponse.response.statusCode == HttpStatus.noContent) {
                  if(mounted) {
                    setState(() {
                      _subscription = null;
                    });
                    Navigator.pop(context);
                  }
                }
              }).catchError((e) {
                print(e.toString());
              });
            },
          ),
          Divider(height: 0.5, thickness: 0.5,),
          ListTile(
            title: Text(S.of(context).all_activity),
            subtitle: Text(S.of(context).msg_repo_watch_all),
            trailing: Icon(Icons.check,
              color: _subscription?.subscribed == true ? null : Colors.transparent,
            ),
            onTap: () {
              githubService.setRepoSubscription(widget.pageArgs.owner, widget.pageArgs.repoName,
                queries: RepoSubscriptionQueriesEntity(true, false),
              ).then((entity) {
                if(mounted) {
                  setState(() {
                    _subscription = entity;
                  });
                  Navigator.pop(context);
                }
              }).catchError((e) {
                print(e.toString());
              });
            },
          ),
          Divider(height: 0.5, thickness: 0.5,),
          ListTile(
            title: Text(S.of(context).ignore),
            subtitle: Text(S.of(context).msg_repo_watch_ignore),
            trailing: Icon(Icons.check,
              color: _subscription?.ignored == true ? null : Colors.transparent,
            ),
            onTap: () {
              githubService.setRepoSubscription(widget.pageArgs.owner, widget.pageArgs.repoName,
                queries: RepoSubscriptionQueriesEntity(false, true),
              ).then((entity) {
                if(mounted) {
                  setState(() {
                    _subscription = entity;
                  });
                  Navigator.pop(context);
                }
              }).catchError((e) {
                print(e.toString());
              });
            },
          ),
          Divider(height: 0.5, thickness: 0.5,),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(height: 0.5, thickness: 0.5,),
        ListTile(
          leading: ImageIcon(getSvgProvider('assets/github/issue-opened-16.svg'), color: Colors.green,),
          title: Text(S.of(context).issues),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Divider(height: 0.5, thickness: 0.5,),
        ListTile(
          leading: ImageIcon(getSvgProvider('assets/github/git-pull-request-16.svg'), color: Colors.blue,),
          title: Text(S.of(context).pull_requests),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Divider(height: 0.5, thickness: 0.5,),
        ListTile(
          leading: ImageIcon(getSvgProvider('assets/github/eye-16.svg'), color: Colors.yellow,),
          title: Text(S.of(context).watchers),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Divider(height: 0.5, thickness: 0.5,),
        ListTile(
          leading: ImageIcon(getSvgProvider('assets/github/law-16.svg'), color: Colors.red),
          title: Text(S.of(context).license),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Divider(height: 0.5, thickness: 0.5,),
      ],
    );
  }
  @override
  void dispose() {
    _titleOpacityController.close();
    super.dispose();
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
