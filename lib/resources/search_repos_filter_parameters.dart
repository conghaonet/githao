import 'package:githao/generated/i18n.dart';
class SearchReposFilterParameters {

  static const PARAMETER_NAME_SORT = "sort";
  static const PARAMETER_NAME_DIRECTION = "direction";
  static const DIRECTION_ASC = "asc";
  static const DIRECTION_DESC = "desc";

  static const SORT_BEST_MATCH = '';
  static const SORT_STARS = 'stars';
  static const SORT_FORKS = 'forks';
  static const SORT_UPDATED = 'updated';



  static final List<Map<String, String>> filterSortValueMap = [
    {PARAMETER_NAME_SORT : SORT_BEST_MATCH, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
    {PARAMETER_NAME_SORT : SORT_STARS, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
    {PARAMETER_NAME_SORT : SORT_STARS, PARAMETER_NAME_DIRECTION : DIRECTION_ASC},
    {PARAMETER_NAME_SORT : SORT_FORKS, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
    {PARAMETER_NAME_SORT : SORT_FORKS, PARAMETER_NAME_DIRECTION : DIRECTION_ASC},
    {PARAMETER_NAME_SORT : SORT_UPDATED, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
    {PARAMETER_NAME_SORT : SORT_UPDATED, PARAMETER_NAME_DIRECTION : DIRECTION_ASC},
  ];
  static List<String> getFilterSortTextMap() {
    return [
      S.current.bestMatch,
      S.current.searchSortStars,
      S.current.searchSortStars,
      S.current.searchSortForks,
      S.current.searchSortForks,
      S.current.searchSortUpdated,
      S.current.searchSortUpdated,
    ];
  }
}
