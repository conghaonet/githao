import 'package:flutter/material.dart';
import 'package:githao/generated/l10n.dart';

class HomeOrganizations extends StatelessWidget {
  const HomeOrganizations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(S.of(context).organizations),
    );
  }
}
