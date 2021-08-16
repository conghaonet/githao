// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `GitHao`
  String get app_name {
    return Intl.message(
      'GitHao',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Flutter for GitHub`
  String get app_desc {
    return Intl.message(
      'Flutter for GitHub',
      name: 'app_desc',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with GitHub`
  String get sing_in_with_github {
    return Intl.message(
      'Sign in with GitHub',
      name: 'sing_in_with_github',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `followers`
  String get followers {
    return Intl.message(
      'followers',
      name: 'followers',
      desc: '',
      args: [],
    );
  }

  /// `following`
  String get following {
    return Intl.message(
      'following',
      name: 'following',
      desc: '',
      args: [],
    );
  }

  /// `Issues`
  String get issues {
    return Intl.message(
      'Issues',
      name: 'issues',
      desc: '',
      args: [],
    );
  }

  /// `Pull Requests`
  String get pull_requests {
    return Intl.message(
      'Pull Requests',
      name: 'pull_requests',
      desc: '',
      args: [],
    );
  }

  /// `Discussions`
  String get discussions {
    return Intl.message(
      'Discussions',
      name: 'discussions',
      desc: '',
      args: [],
    );
  }

  /// `Repositories`
  String get repositories {
    return Intl.message(
      'Repositories',
      name: 'repositories',
      desc: '',
      args: [],
    );
  }

  /// `Organizations`
  String get organizations {
    return Intl.message(
      'Organizations',
      name: 'organizations',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get popular {
    return Intl.message(
      'Popular',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Starred`
  String get starred {
    return Intl.message(
      'Starred',
      name: 'starred',
      desc: '',
      args: [],
    );
  }

  /// `Recent Searches`
  String get recent_searches {
    return Intl.message(
      'Recent Searches',
      name: 'recent_searches',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Watchers`
  String get watchers {
    return Intl.message(
      'Watchers',
      name: 'watchers',
      desc: '',
      args: [],
    );
  }

  /// `License`
  String get license {
    return Intl.message(
      'License',
      name: 'license',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `App Language`
  String get app_language {
    return Intl.message(
      'App Language',
      name: 'app_language',
      desc: '',
      args: [],
    );
  }

  /// `Manage Accounts`
  String get manage_accounts {
    return Intl.message(
      'Manage Accounts',
      name: 'manage_accounts',
      desc: '',
      args: [],
    );
  }

  /// `Add Account`
  String get add_account {
    return Intl.message(
      'Add Account',
      name: 'add_account',
      desc: '',
      args: [],
    );
  }

  /// `Collaborator`
  String get collaborator {
    return Intl.message(
      'Collaborator',
      name: 'collaborator',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get owner {
    return Intl.message(
      'Owner',
      name: 'owner',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong.`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong.',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get try_again {
    return Intl.message(
      'Try Again',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `Private`
  String get private {
    return Intl.message(
      'Private',
      name: 'private',
      desc: '',
      args: [],
    );
  }

  /// `Stars`
  String get stars {
    return Intl.message(
      'Stars',
      name: 'stars',
      desc: '',
      args: [],
    );
  }

  /// `Forks`
  String get forks {
    return Intl.message(
      'Forks',
      name: 'forks',
      desc: '',
      args: [],
    );
  }

  /// `Star`
  String get star {
    return Intl.message(
      'Star',
      name: 'star',
      desc: '',
      args: [],
    );
  }

  /// `Watch`
  String get watch {
    return Intl.message(
      'Watch',
      name: 'watch',
      desc: '',
      args: [],
    );
  }

  /// `Watching`
  String get watching {
    return Intl.message(
      'Watching',
      name: 'watching',
      desc: '',
      args: [],
    );
  }

  /// `Ignore`
  String get ignore {
    return Intl.message(
      'Ignore',
      name: 'ignore',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Participating and @mentions`
  String get participating_and_mentions {
    return Intl.message(
      'Participating and @mentions',
      name: 'participating_and_mentions',
      desc: '',
      args: [],
    );
  }

  /// `Only receive notifications frm this repository when participation or @mentions.`
  String get msg_repo_no_watch {
    return Intl.message(
      'Only receive notifications frm this repository when participation or @mentions.',
      name: 'msg_repo_no_watch',
      desc: '',
      args: [],
    );
  }

  /// `All Activity`
  String get all_activity {
    return Intl.message(
      'All Activity',
      name: 'all_activity',
      desc: '',
      args: [],
    );
  }

  /// `Notified of all notifications on this repository.`
  String get msg_repo_watch_all {
    return Intl.message(
      'Notified of all notifications on this repository.',
      name: 'msg_repo_watch_all',
      desc: '',
      args: [],
    );
  }

  /// `Never be notified.`
  String get msg_repo_watch_ignore {
    return Intl.message(
      'Never be notified.',
      name: 'msg_repo_watch_ignore',
      desc: '',
      args: [],
    );
  }

  /// `Forked from`
  String get forked_from {
    return Intl.message(
      'Forked from',
      name: 'forked_from',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
