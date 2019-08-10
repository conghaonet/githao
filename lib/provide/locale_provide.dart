import 'package:flutter/widgets.dart';

class LocaleProvide with ChangeNotifier {
  Locale _locale;
  Locale get locale => _locale;

  changeLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}