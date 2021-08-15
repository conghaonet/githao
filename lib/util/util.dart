import 'package:flutter/cupertino.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class Util {
}
Svg getSvgProvider(String path, {Size size = const Size(16, 16)}) {
  return Svg(path, size: size);
}
