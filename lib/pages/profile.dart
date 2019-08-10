import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/provide/user_provide.dart';
import 'package:githao/routes/profile_page_args.dart';
import 'package:intl/intl.dart';
import 'package:provide/provide.dart';

class ProfilePage extends StatefulWidget {
  static const ROUTE_NAME = '/profile';
  final ProfilePageArgs args;
  ProfilePage(this.args, {Key key}): super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<String> _tabTitles;
  TabController _tabController;
  bool _isAuthenticatedUser = false;
  UserEntity _userEntity;
  //要达到缓存目的，必须实现AutomaticKeepAliveClientMixin的wantKeepAlive为true。
  // 不会被销毁,占内存中
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
    });
    ApiService.getUser(widget.args.login).then((user){
      if(mounted) {
        setState(() {
          if(Provide.value<UserProvide>(context).user.login == widget.args.login) {
            _isAuthenticatedUser = true;
          }
          this._userEntity = user;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context); //混入AutomaticKeepAliveClientMixin后，必须添加
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              primary: true,
              floating: true, //是否随着滑动隐藏标题，为true时，当有下滑手势的时候就会显示SliverAppBar
              snap:false,   //与floating结合使用
              pinned: false, //为true时，SliverAppBar折叠后不消失
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.args.login),
                centerTitle: true,
                collapseMode: CollapseMode.parallax, // 背景折叠动画
                background: _appBarBackground(),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                Container(
                  color: Theme.of(context).primaryColor,
                  child: TabBar(
                    indicatorColor: Theme.of(context).primaryColorLight,
                    controller: _tabController,
                    tabs: [
                      Tab(child: Text(S.of(context).infoUppercase),),
                      Tab(child: Text(S.of(context).activityUppercase),),
                      Tab(child: Text(S.of(context).starredUppercase),),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _getInfoTabBarView(),
              Container(
                child: Center(child: Text('tab1'),),
              ),
              Container(
                child: RefreshIndicator(
                  onRefresh: () {
                    return;
                  },
                  child: ListView.builder(
                    itemCount: 99,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: 50,
                        child: Text("index $index"),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBarBackground() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: widget.args.avatarUrl,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.7),
            colorBlendMode: BlendMode.srcOver,),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: widget.args.heroTag,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: CachedNetworkImageProvider(widget.args.avatarUrl)),
                  ),
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Offstage(
                      offstage: this._userEntity?.name == null,
                      child: Text(this._userEntity?.name ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 18,),
                      ),
                    ),
                    Offstage(
                      offstage: this._userEntity?.location == null,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.location_on, color: Colors.white, size: 16,),
                          Expanded(
                            child: Text(this._userEntity?.location ?? '',
                              softWrap: true,
                              maxLines: 3,
                              style: TextStyle(color: Colors.white, fontSize: 16,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getInfoTabBarView() {
    if(_userEntity == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      DateTime createdAt = DateTime.parse(_userEntity.createdAt).toLocal();
      DateTime updatedAt = DateTime.parse(_userEntity.updatedAt).toLocal();
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Offstage(
                offstage: this._userEntity.name == null,
                child: Text(this._userEntity.name ?? '',
                  style: TextStyle(fontSize: 18,),
                ),
              ),
              SizedBox(height: 8,),
              Text(S.of(context).createdAt(dateFormat.format(createdAt)),
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 8,),
              Text(S.of(context).updatedAt(dateFormat.format(updatedAt)),
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Offstage(
                offstage: this._userEntity.email == null,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.email, color: Theme.of(context).primaryColorDark),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Text(this._userEntity.email ?? '',
                          style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Offstage(
                offstage: this._userEntity.blog == null,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.link, color: Theme.of(context).primaryColorDark),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Text(this._userEntity.blog ?? '',
                          style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Column(
                          children: <Widget>[
                            Text('${_userEntity.followers}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,),),
                            Text(S.of(context).followers, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Column(
                          children: <Widget>[
                            Text('${_userEntity.following}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,),),
                            Text(S.of(context).following, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Column(
                          children: <Widget>[
                            Text('${_userEntity.publicRepos}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,),),
                            Text(S.of(context).repositories, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Column(
                          children: <Widget>[
                            Text('${_userEntity.publicGists ?? 0}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold,),),
                            Text(S.of(context).gists, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Text(_userEntity.bio == null ? '' : '${_userEntity.bio}', maxLines: 5, style: TextStyle(fontSize: 16),),
            ],
          )
        ),
      );
    }
  }
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Container _tabBar;
  _SliverAppBarDelegate(this._tabBar);
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }
  @override
  double get maxExtent => 48;
  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}