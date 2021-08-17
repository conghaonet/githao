import 'dart:io';

import 'package:flutter/material.dart';
import 'package:githao/generated/l10n.dart';
import 'package:githao/network/entity/activity/repo_subscription_entity.dart';
import 'package:githao/network/entity/activity/repo_subscription_queries_entity.dart';
import 'package:githao/network/github_service.dart';

class SelectNotificationsView extends StatefulWidget {
  final String owner;
  final String repoName;
  final RepoSubscriptionEntity? subscription;
  final ValueChanged<RepoSubscriptionQueriesEntity?> callback;
  const SelectNotificationsView({
    required this.owner, 
    required this.repoName,
    required this.subscription,
    required this.callback, 
    Key? key
  }) : super(key: key);

  @override
  _SelectNotificationsViewState createState() => _SelectNotificationsViewState();
}

class _SelectNotificationsViewState extends State<SelectNotificationsView> {
  @override
  Widget build(BuildContext context) {
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
            trailing: Icon(Icons.check, color: widget.subscription == null ? null : Colors.transparent,),
            onTap: () {
              githubService.delRepoSubscription(widget.owner, widget.repoName).catchError((e) {
                print(e.toString());
              });
              widget.callback(null);
              Navigator.pop(context);
            },
          ),
          Divider(height: 0.5, thickness: 0.5,),
          ListTile(
            title: Text(S.of(context).all_activity),
            subtitle: Text(S.of(context).msg_repo_watch_all),
            trailing: Icon(Icons.check,
              color: widget.subscription?.subscribed == true ? null : Colors.transparent,
            ),
            onTap: () {
              final queries =RepoSubscriptionQueriesEntity(true, false);
              githubService.setRepoSubscription(widget.owner, widget.repoName,
                queries: queries,
              ).catchError((e) {
                print(e.toString());
              });
              widget.callback(queries);
              Navigator.pop(context);
            },
          ),
          Divider(height: 0.5, thickness: 0.5,),
          ListTile(
            title: Text(S.of(context).ignore),
            subtitle: Text(S.of(context).msg_repo_watch_ignore),
            trailing: Icon(Icons.check,
              color: widget.subscription?.ignored == true ? null : Colors.transparent,
            ),
            onTap: () {
              final queries = RepoSubscriptionQueriesEntity(false, true);
              githubService.setRepoSubscription(widget.owner, widget.repoName,
                queries: queries,
              ).catchError((e) {
                print(e.toString());
              });
              widget.callback(queries);
              Navigator.pop(context);

            },
          ),
          Divider(height: 0.5, thickness: 0.5,),
        ],
      ),
    );
  }
}
