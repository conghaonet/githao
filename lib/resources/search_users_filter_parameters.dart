import 'package:githao/generated/i18n.dart';
class SearchUsersFilterParameters {

  static const PARAMETER_NAME_SORT = "sort";
  static const PARAMETER_NAME_DIRECTION = "direction";
  static const DIRECTION_ASC = "asc";
  static const DIRECTION_DESC = "desc";

  static const SORT_BEST_MATCH = '';
  static const SORT_FOLLOWERS = 'followers';
  static const SORT_JOINED = 'joined';
  static const SORT_REPOSITORIES = 'repositories';



  static final List<Map<String, String>> filterSortValueMap = [
    {PARAMETER_NAME_SORT : SORT_BEST_MATCH, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
    {PARAMETER_NAME_SORT : SORT_FOLLOWERS, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
    {PARAMETER_NAME_SORT : SORT_FOLLOWERS, PARAMETER_NAME_DIRECTION : DIRECTION_ASC},
    {PARAMETER_NAME_SORT : SORT_JOINED, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
    {PARAMETER_NAME_SORT : SORT_JOINED, PARAMETER_NAME_DIRECTION : DIRECTION_ASC},
    {PARAMETER_NAME_SORT : SORT_REPOSITORIES, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
    {PARAMETER_NAME_SORT : SORT_REPOSITORIES, PARAMETER_NAME_DIRECTION : DIRECTION_ASC},
  ];

  static List<String> getFilterSortTextMap() {
    return [
      S.current.bestMatch,
      S.current.followers,
      S.current.followers,
      S.current.recentlyJoined,
      S.current.recentlyJoined,
      S.current.repositories,
      S.current.repositories,
    ];
  }
}
