import 'package:flutter/material.dart';
import 'package:githao/generated/l10n.dart';

class ErrorView extends StatelessWidget {
  final VoidCallback? callback;
  const ErrorView({this.callback, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(S.of(context).something_went_wrong),
        if(this.callback != null)
          ElevatedButton(
            onPressed: callback,
            child: Text(S.of(context).try_again),
          ),
      ],
    );
  }
}
