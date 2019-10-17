import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/resources/search_users_filter_parameters.dart';

class SearchUsersFilter extends StatefulWidget {

  final int selectedSortIndex;
  final Function(int) callback;
  SearchUsersFilter(this.selectedSortIndex, this.callback);
  @override
  _SearchUsersFilterState createState() => _SearchUsersFilterState();
}

class _SearchUsersFilterState extends State<SearchUsersFilter> {
  int _selectedSortIndex;
  @override
  void initState() {
    super.initState();
    _selectedSortIndex = widget.selectedSortIndex;
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
              S.current.sort,
              style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w700),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: List<Widget>.generate(SearchUsersFilterParameters.getFilterSortTextMap().length, (int index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8, left: 8),
                  child: ChoiceChip(
                    label: Padding(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(SearchUsersFilterParameters.getFilterSortTextMap()[index],
                            style: TextStyle(color: _selectedSortIndex == index ? Colors.white : Colors.black45),
                          ),
                          Icon(SearchUsersFilterParameters.filterSortValueMap[index][SearchUsersFilterParameters.PARAMETER_NAME_DIRECTION] == SearchUsersFilterParameters.DIRECTION_ASC
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
                      widget.callback(index);
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