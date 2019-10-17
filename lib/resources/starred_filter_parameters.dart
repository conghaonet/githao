import 'package:githao/generated/i18n.dart';
class StarredFilterParameters {

  static const PARAMETER_NAME_SORT = "sort";
  static const PARAMETER_NAME_DIRECTION = "direction";
  static const DIRECTION_ASC = "asc";
  static const DIRECTION_DESC = "desc";

  static const SORT_CREATED = "created";
  static const SORT_UPDATED = "updated";

  static final List<Map<String, String>> filterSortValueMap = [
    {PARAMETER_NAME_SORT : SORT_CREATED, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
    {PARAMETER_NAME_SORT : SORT_CREATED, PARAMETER_NAME_DIRECTION : DIRECTION_ASC},
    {PARAMETER_NAME_SORT : SORT_UPDATED, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
    {PARAMETER_NAME_SORT : SORT_UPDATED, PARAMETER_NAME_DIRECTION : DIRECTION_ASC},
  ];

  static List<String> getFilterSortTextMap() {
    return [
      S.current.created,
      S.current.created,
      S.current.updated,
      S.current.updated,
    ];
  }
}
