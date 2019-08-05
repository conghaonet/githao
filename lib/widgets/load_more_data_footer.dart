import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
class LoadMoreDataFooter extends StatelessWidget {
  final bool hasMoreData;
  LoadMoreDataFooter(this.hasMoreData, {Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    if(hasMoreData) {
      return Container(
        height: 50,
        alignment: Alignment.center,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              S.of(context).loadingMoreData,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            SizedBox(width: 8,),
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 50,
        alignment: Alignment.center,
        color: Colors.white,
        child: Text(
          S.of(context).noMoreData,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      );
    }
  }
}