import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/resources/repos_filter_parameters.dart';

class MyReposFilter extends StatefulWidget {
  static const GROUP_TYPE = 'type';
  static const GROUP_SORT = 'sort';
  final List<String> typeTexts;
  final List<String> sortTexts;
  final int selectedTypeIndex;
  final int selectedSortIndex;
  final Function(String, int) callback;
  MyReposFilter(this.selectedTypeIndex ,this.typeTexts, this.selectedSortIndex, this.sortTexts, this.callback);
  @override
  _MyReposFilterState createState() => _MyReposFilterState();
}

class _MyReposFilterState extends State<MyReposFilter> {
  int _selectedTypeIndex;
  int _selectedSortIndex;
  @override
  void initState() {
    _selectedTypeIndex = widget.selectedTypeIndex;
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
              S.current.reposFilterType,
              style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w700),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: List<Widget>.generate(widget.typeTexts.length, (int index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8, left: 8),
                  child: ChoiceChip(
                    label: Padding(
                      padding: widget.typeTexts[index].length < 5 ? EdgeInsets.only(left: 12, right: 12,) : EdgeInsets.only(left: 4, right: 4,),
                      child: Text(widget.typeTexts[index],
                        style: TextStyle(color: _selectedTypeIndex == index ? Colors.white : Colors.black45),
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColorLight,
                    selectedColor: Theme.of(context).primaryColorDark,
                    selected: _selectedTypeIndex == index,
                    onSelected: (bool isSelected) {
                      _selectedTypeIndex = isSelected ? index : -1;
                      widget.callback(MyReposFilter.GROUP_TYPE, index);
                      Navigator.pop(context);
                    },
                  ),
                );
              }).toList(growable: false),
            ),
          ),
          Divider(),
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
                          Icon(ReposFilterParameters.filterSortValueMap[index][ReposFilterParameters.PARAMETER_NAME_DIRECTION] == ReposFilterParameters.DIRECTION_ASC
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
                      widget.callback(MyReposFilter.GROUP_SORT, index);
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