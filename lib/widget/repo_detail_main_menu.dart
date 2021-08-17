import 'package:flutter/material.dart';
import 'package:githao/generated/l10n.dart';
import 'package:githao/network/entity/repo/repo_entity.dart';
import 'package:githao/util/util.dart';

class RepoDetailMainMenu extends StatefulWidget {
  final RepoEntity repo;
  const RepoDetailMainMenu(this.repo, {Key? key}) : super(key: key);

  @override
  _RepoDetailMainMenuState createState() => _RepoDetailMainMenuState();
}

class _RepoDetailMainMenuState extends State<RepoDetailMainMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
      ],
    );
  }
}
