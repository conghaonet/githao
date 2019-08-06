import 'package:flutter/widgets.dart';
import 'package:githao/generated/i18n.dart';

class ReposFilterParameters {
  static const PARAMETER_NAME_TYPE = "type";
  static const PARAMETER_NAME_SORT = "sort";
  static const PARAMETER_NAME_DIRECTION = "direction";
  
  static const TYPE_ALL = "all";
  static const TYPE_OWNER = "owner";
  static const TYPE_PUBLIC = "public";
  static const TYPE_PRIVATE = "private";
  static const TYPE_MEMBER = "member";

  static const SORT_FULL_NAME = "full_name";
  static const SORT_CREATED = "created";
  static const SORT_UPDATED = "updated";
  static const SORT_PUSHED = "pushed";

  static const DIRECTION_ASC = "asc";
  static const DIRECTION_DESC = "desc";

  static final Map<String, Map<String, String>> filterTypeValueMap = {
    TYPE_ALL : {PARAMETER_NAME_TYPE : TYPE_ALL},
    TYPE_OWNER : {PARAMETER_NAME_TYPE : TYPE_OWNER},
    TYPE_PUBLIC : {PARAMETER_NAME_TYPE : TYPE_PUBLIC},
    TYPE_PRIVATE : {PARAMETER_NAME_TYPE : TYPE_PRIVATE},
    TYPE_MEMBER : {PARAMETER_NAME_TYPE : TYPE_MEMBER},
  };

  static Map<String, String> getFilterTypeTextMap(BuildContext context) {
    Map<String, String> _filterTypeTextMap = {
      TYPE_ALL : S.of(context).reposFilterTypeAll,
      TYPE_OWNER : S.of(context).reposFilterTypeOwner,
      TYPE_PUBLIC : S.of(context).reposFilterTypePublic,
      TYPE_PRIVATE : S.of(context).reposFilterTypePrivate,
      TYPE_MEMBER : S.of(context).reposFilterTypeMember,
    };
    return _filterTypeTextMap;
  }

  static final Map<String, Map<String, String>> filterSortValueMap = {
    '$SORT_FULL_NAME-$DIRECTION_ASC' : {PARAMETER_NAME_SORT : SORT_FULL_NAME, PARAMETER_NAME_DIRECTION : DIRECTION_ASC},
    '$SORT_FULL_NAME-$DIRECTION_DESC' : {PARAMETER_NAME_SORT : SORT_FULL_NAME, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
    '$SORT_CREATED-$DIRECTION_ASC' : {PARAMETER_NAME_SORT : SORT_CREATED, PARAMETER_NAME_DIRECTION : DIRECTION_ASC},
    '$SORT_CREATED-$DIRECTION_DESC': {PARAMETER_NAME_SORT : SORT_CREATED, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
    '$SORT_UPDATED-$DIRECTION_ASC': {PARAMETER_NAME_SORT : SORT_UPDATED, PARAMETER_NAME_DIRECTION : DIRECTION_ASC},
    '$SORT_UPDATED-$DIRECTION_DESC' : {PARAMETER_NAME_SORT : SORT_UPDATED, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
    '$SORT_PUSHED-$DIRECTION_ASC' : {PARAMETER_NAME_SORT : SORT_PUSHED, PARAMETER_NAME_DIRECTION : DIRECTION_ASC},
    '$SORT_PUSHED-$DIRECTION_DESC' : {PARAMETER_NAME_SORT : SORT_PUSHED, PARAMETER_NAME_DIRECTION : DIRECTION_DESC},
  };

  static Map<String, String> getFilterSortTextMap(BuildContext context) {
    Map<String, String> _filterSortTextMap = {
      '$SORT_FULL_NAME-$DIRECTION_ASC': S.of(context).reposFilterSortFullName,
      '$SORT_FULL_NAME-$DIRECTION_DESC': S.of(context).reposFilterSortFullName,
      '$SORT_CREATED-$DIRECTION_ASC' : S.of(context).reposFilterSortCreated,
      '$SORT_CREATED-$DIRECTION_DESC': S.of(context).reposFilterSortCreated,
      '$SORT_UPDATED-$DIRECTION_ASC': S.of(context).reposFilterSortUpdated,
      '$SORT_UPDATED-$DIRECTION_DESC' : S.of(context).reposFilterSortUpdated,
      '$SORT_PUSHED-$DIRECTION_ASC' : S.of(context).reposFilterSortPushed,
      '$SORT_PUSHED-$DIRECTION_DESC' : S.of(context).reposFilterSortPushed,
    };
    return _filterSortTextMap;
  }
}