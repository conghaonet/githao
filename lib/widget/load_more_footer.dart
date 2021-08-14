import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadMoreFooter extends StatelessWidget {
  const LoadMoreFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: double.infinity,
      child: CupertinoActivityIndicator(),
    );
  }
}
