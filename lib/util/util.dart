import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_manager.dart';

class Util {
  static SvgPicture getSvgIcon(String asset, {
    double width = 24,
    double height = 24,
    Color? color
  }) {
    return SvgPicture.asset(asset,
      width: width,
      height: height,
      color: color ?? Theme.of(navigatorState.currentState!.context).iconTheme.color,
    );
  }
}