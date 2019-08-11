import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/resources/starred_filter_parameters.dart';

class StarredReposFilter extends StatefulWidget {
  static const GROUP_SORT = 'sort';
  final List<String> sortTexts;
  final int selectedSortIndex;
  final Function(String, int) callback;
  StarredReposFilter(this.selectedSortIndex, this.sortTexts, this.callback);
  @override
  _StarredReposFilterState createState() => _StarredReposFilterState();
}

class _StarredReposFilterState extends State<StarredReposFilter> {
  int _selectedSortIndex;
  @override
  void initState() {
    _selectedSortIndex = widget.selectedSortIndex;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 0),
            child: Text(
              S.current.reposFilterSort,
              style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w700),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: List<Widget>.generate(widget.sortTexts.length, (int index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8, left: 8),
                  child: ChoiceChip(
                    label: Padding(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.sortTexts[index],
                            style: TextStyle(color: _selectedSortIndex == index ? Colors.white : Colors.black45),
                          ),
                          Icon(StarredFilterParameters.filterSortValueMap[index][StarredFilterParameters.PARAMETER_NAME_DIRECTION] == StarredFilterParameters.DIRECTION_ASC
                              ? Icons.trending_up
                              : Icons.trending_down,
                            color: _selectedSortIndex == index ? Colors.white : Colors.black45,),
                        ],
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColorLight,
                    selectedColor: Theme.of(context).primaryColorDark,
                    selected: _selectedSortIndex == index,
                    onSelected: (bool isSelected) {
                      _selectedSortIndex = isSelected ? index : -1;
                      widget.callback(StarredReposFilter.GROUP_SORT, index);
                      Navigator.pop(context);
                    },
                  ),
                );
              }).toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }
}