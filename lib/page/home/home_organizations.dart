import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/entity/org/org_entity.dart';
import 'package:githao/network/github_service.dart';
import 'package:githao/util/const.dart';
import 'package:githao/widget/org_item_view.dart';

class HomeOrganizations extends StatefulWidget {
  const HomeOrganizations({Key? key}) : super(key: key);

  @override
  _HomeOrganizationsState createState() => _HomeOrganizationsState();
}

class _HomeOrganizationsState extends State<HomeOrganizations> {
  final List<OrgEntity> _orgs = [];
  int _stackIndex = 0;
  int _page = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData({bool isLoadMore = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    if (isLoadMore) {
      ++_page;
    } else {
      _page = 1;
    }
    try {
      final result = await githubService.getMyOrgs(
        // 'conghaonet',
        cacheable: _stackIndex == 0,
      );
      if (_page == 1) {
        _orgs.clear();
      } else if (_page > 1 && result.isEmpty) {
        _page -= 1;
      }
      _orgs.addAll(result);
      if (mounted) {
        setState(() {
          _isLoading = false;
          _stackIndex = 1;
        });
      }
    } catch (e) {} finally {
      _isLoading = false;
    }
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IndexedStack(
        index: _stackIndex,
        children: [
          Center(
              child: CupertinoActivityIndicator(
                radius: 20,
              )),
          RefreshIndicator(
            onRefresh: _loadData,
            child: ListView.separated(
              itemCount: _orgs.isNotEmpty && (_orgs.length % Const.perPageNormal) == 0
                  ? _orgs.length + 1
                  : _orgs.length,
              itemBuilder: (context, index) {
                if (index < _orgs.length) {
                  return OrgItemView(_orgs[index]);
                } else {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _loadData(isLoadMore: true);
                  });
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 0.5,
                  thickness: 0.5,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
