import 'package:flutter/material.dart';
import 'package:githao/generated/l10n.dart';

class HomeSettings extends StatelessWidget {
  const HomeSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(S.of(context).settings),
    );
  }
}

