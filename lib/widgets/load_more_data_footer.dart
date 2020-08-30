import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';

import 'loading_state.dart';
class LoadMoreDataFooter extends StatelessWidget {
  final bool hasMoreData;
  final StateFlag flag;
  final Function onRetry;
  static final footerHeight = 50.0;
  LoadMoreDataFooter(this.hasMoreData, {Key key, this.flag, this.onRetry}): super(key: key);
  @override
  Widget build(BuildContext context) {
    if(flag != null && flag == StateFlag.error) {
      return Container(
        height: footerHeight,
        alignment: Alignment.center,
        color: Colors.white,
        child: FlatButton(
          onPressed: () => onRetry(),
          child: Text(S.current.tapToRetry, style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),),
        ),
      );
    } else {
      if(hasMoreData) {
        return Container(
          height: footerHeight,
          alignment: Alignment.center,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                S.current.loadingMoreData,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              SizedBox(width: 8,),
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2
                ),
              ),
            ],
          ),
        );
      } else {
        return Container(
          height: footerHeight,
          alignment: Alignment.center,
          color: Colors.white,
          child: Text(
            S.current.noMoreData,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        );
      }
    }
  }
}