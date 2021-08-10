extension IntExtension on int {
  String toFriendly({int fractionDigits = 1}) {
    int billion = 1000000000;
    int million = 1000000;
    int kilo = 1000;
    String suffix = '';
    double value = this.toDouble();
    if(this >= billion) {
      suffix = 'B';
      value = this.toDouble() / billion;
    } else if(this >= million) {
      suffix = 'M';
      value = this.toDouble() / million;
    } else if(this >= kilo) {
      suffix = 'K';
      value = this.toDouble() / kilo;
    }
    if((value % 1) > 0 && fractionDigits > 0) {
      int endIndex = value.toString().indexOf('.') + 1 + fractionDigits;
      return value.toString().substring(0, endIndex) + suffix;
    } else return value.toInt().toString() + suffix;
  }
}