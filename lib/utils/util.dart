import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
/*
  static void showSnackBar(ScaffoldState scaffoldState, {String strContent , Widget content, SnackBarAction action}) {
    if(strContent == null && content == null) {
      return;
    }
    try {
      Widget msgContent = content ?? Text(strContent);
      scaffoldState.showSnackBar(
        SnackBar(content: msgContent, action: action,),
      );
    } on FlutterError catch(e) {
      // Scaffold.of() called with a context that does not contain a Scaffold.
      throw e;
    }
  }
*/

  static CancelFunc showToast(String message,) {
    return BotToast.showText(
      text: message ?? 'null',
      contentColor: Colors.black87,
      textStyle: const TextStyle(fontSize: 14, color: Colors.white,),
    );
  }

  static Future<ConnectivityResult> networkIsConnective() async {
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return connectivityResult;
    } else {
      return null;
    }
  }

  static String getFriendlyDateTime(String time) {
    String friendlyTime;
    if(time == null || time.isEmpty) return friendlyTime;
    try {
      DateTime dateTime = DateTime.parse(time).toLocal();
      DateTime now = DateTime.now();
      Duration difference = dateTime.difference(now);
      DateFormat uiFormat = DateFormat('yyyy-MM-dd HH:mm');
      friendlyTime = uiFormat.format(dateTime);
      if(difference.inMilliseconds < 0) {
        difference = difference.abs();
        if(dateTime.year != now.year) {
          uiFormat = DateFormat('yyyy-MM-dd');
          friendlyTime = uiFormat.format(dateTime);
        } else if(dateTime.month != now.month) {
          uiFormat = DateFormat('MM-dd');
          friendlyTime = uiFormat.format(dateTime);
        } else if(dateTime.day != now.day) {
          int days = difference.inDays;
          if(days == 0) ++days;
          friendlyTime = '$days days ago';
        } else if(dateTime.hour != now.hour) {
          int hours = difference.inHours;
          if(hours == 0) ++hours;
          friendlyTime = '$hours hours ago';
        } else if(dateTime.minute != now.minute) {
          int minutes = difference.inMinutes;
          if(minutes == 0) ++minutes;
          friendlyTime = '$minutes minutes ago';
        } else if(dateTime.second != now.second) {
          int seconds = difference.inSeconds;
          if(seconds == 0) ++seconds;
          friendlyTime = '$seconds seconds ago';
        }
      }
    } catch(e) {
      print(e.toString());
    }
    return friendlyTime;
  }

}