import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/resources/lang_colors.dart';
import 'package:githao/resources/trending_filter_parameters.dart';

import 'base_repos.dart';
import 'dart:math' as math;

const _FILTER_GROUP_TIME_SPAN = 'time_span';
const _FILTER_GROUP_LANGUAGE = 'language';

class TrendingReposWidget extends BaseReposWidget{
  final UserEntity user;
  TrendingReposWidget({Key key, this.user, needLoadMore=false,}): super(key: key, needLoadMore: needLoadMore);
  @override
  _StarredReposWidgetState createState() => _StarredReposWidgetState();
}

class _StarredReposWidgetState extends BaseReposWidgetState<TrendingReposWidget> {
  int _timeSpanIndex = 0;
  int _languageIndex;

  @override
  Future<List<RepoEntity>> getRepos(final int expectationPage){
    String _since = TrendingFilterParameters.filterSinceValueMap[_timeSpanIndex][TrendingFilterParameters.PARAMETER_NAME_SINCE];
    String _language = '';
    if(_languageIndex != null && _languageIndex >= 0 && _languageIndex < LANG_COLORS.length) {
      _language = LANG_COLORS.entries.elementAt(_languageIndex).key.toLowerCase().replaceAll(' ', '-');
    }
    return ApiService.getTrending(since:  _since, language: _language);
  }

  void onClickFilterCallback(String group, int index) {
    if(group == _FILTER_GROUP_TIME_SPAN) {
      if( _timeSpanIndex != index) {
        setState(() {
          _timeSpanIndex = index;
        });
        refreshIndicatorKey.currentState.show();
      }
    } else if(group == _FILTER_GROUP_LANGUAGE) {
      if( _languageIndex != index) {
        setState(() {
          _languageIndex = index;
        });
        refreshIndicatorKey.currentState.show();
      }
    }
  }

  @override
  Widget getFilter() {
    return TrendingFilter(
        this._timeSpanIndex,
        this._languageIndex,
        TrendingFilterParameters.getFilterTimeSpanTextMap(context),
        onClickFilterCallback);
  }

}


class TrendingFilter extends StatefulWidget {

  final int timeSpanIndex;
  final int languageIndex;
  final List<String> timeSpanTexts;
  final Function(String, int) callback;

  TrendingFilter(this.timeSpanIndex, this.languageIndex, this.timeSpanTexts, this.callback, {Key key}):super(key: key);
  @override
  _TrendingFilterState createState() => _TrendingFilterState();
}

class _TrendingFilterState extends State<TrendingFilter> {
  List<Widget> _buildTimeSpans() {
    List<Widget> _spans = [];
    for(int i=0; i<widget.timeSpanTexts.length; i++) {
      Widget _widget = Expanded(
        child: ChoiceChip(
          labelPadding: EdgeInsets.symmetric(horizontal: 16,),
          label: Text(widget.timeSpanTexts[i],
            style: TextStyle(color: widget.timeSpanIndex == i ? Colors.white : Colors.black45),
          ),
          backgroundColor: Theme.of(context).primaryColorLight,
          selectedColor: Theme.of(context).primaryColorDark,
          selected: widget.timeSpanIndex == i,
          onSelected: (bool isSelected) {
            widget.callback(_FILTER_GROUP_TIME_SPAN, i);
            Navigator.pop(context);
          },
        ),
      );
      _spans.add(_widget);
    }
    return _spans;
  }

  List<DropdownMenuItem<int>> _buildLanguages() {
    List<DropdownMenuItem<int>> _items = [];
    for(int i = 0; i < LANG_COLORS.length; i++) {
      var item = DropdownMenuItem<int>(
        value: i,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              LANG_COLORS.entries.elementAt(i).key,
              style: TextStyle(
                color: i == widget.languageIndex ? Theme.of(context).primaryColor : Colors.black54,
                fontWeight: i == widget.languageIndex ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      );
      _items.add(item);
    }
    return _items;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 0),
            child: Text(
              S.current.adjustTimeSpan,
              style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w700),),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: _buildTimeSpans(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 0),
            child: Text(
              S.current.selectALanguage,
              style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w700),),
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              alignment: AlignmentDirectional.center,
//              mainAxisSize: MainAxisSize.min,
//              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DropdownButton<int>(
                  isExpanded: false,
                  value: widget.languageIndex,
                  hint: Text('——${S.current.selectALanguage}——'),
                  items: _buildLanguages(),
                  onChanged: (selected) {
                    widget.callback(_FILTER_GROUP_LANGUAGE, selected);
                    Navigator.pop(context);
                  },
                ),
                Positioned(
                  right: 12,
                  child: Offstage(
                    offstage: widget.languageIndex == null,
                    child: Transform.rotate(
                      angle: math.pi/4, //旋转45度
                      child: IconButton(
                        color: Colors.grey,
                        icon: Icon(Icons.add_circle),
                        onPressed: () {
                          widget.callback(_FILTER_GROUP_LANGUAGE, null);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24,),
        ],
      ),
    );
  }
}