import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/resources/trending_filter_parameters.dart';

import 'base_repos.dart';

class TrendingReposWidget extends BaseReposWidget{
  final UserEntity user;
  TrendingReposWidget({Key key, this.user, needLoadMore=false,}): super(key: key, needLoadMore: needLoadMore);
  @override
  _StarredReposWidgetState createState() => _StarredReposWidgetState();
}

class _StarredReposWidgetState extends BaseReposWidgetState<TrendingReposWidget> {
  int _timeSpanIndex = 0;

  @override
  Future<List<RepoEntity>> getRepos(final int expectationPage){
    String _since = TrendingFilterParameters.filterSinceValueMap[_timeSpanIndex][TrendingFilterParameters.PARAMETER_NAME_SINCE];
    return ApiService.getTrending(since:  _since);
  }

  void onClickFilterCallback(int index) {
      if( _timeSpanIndex != index) {
        setState(() {
          _timeSpanIndex = index;
        });
        refreshIndicatorKey.currentState.show();
      }
  }

  @override
  Widget getFilter() {
    return TrendingFilter(
        this._timeSpanIndex,
        TrendingFilterParameters.getFilterTimeSpanTextMap(context),
        onClickFilterCallback);
  }

}


class TrendingFilter extends StatefulWidget {
  final int timeSpanIndex;
  final List<String> timeSpanTexts;
  final Function(int) callback;

  TrendingFilter(this.timeSpanIndex, this.timeSpanTexts, this.callback, {Key key}):super(key: key);
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
            widget.callback(i);
            Navigator.pop(context);
          },
        ),
      );
      _spans.add(_widget);
    }
    return _spans;
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
        ],
      ),
    );
  }
}