import 'package:flutter/cupertino.dart';
import 'package:githao/util/prefs_manager.dart';

class LocaleNotifier extends ChangeNotifier {
  static final LocaleNotifier _localeNotifier = LocaleNotifier._internal();
  factory LocaleNotifier() => _localeNotifier;
  LocaleNotifier._internal();
  Locale? get locale => prefsManager.initialized ? prefsManager.getLocale() : null;
  void notify() {
    notifyListeners();
  }
}

LocaleNotifier localeNotifier = LocaleNotifier();