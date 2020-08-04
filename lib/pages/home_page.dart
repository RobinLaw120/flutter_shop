import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/home_child/tab_page.dart';
import '../service/service_method.dart';

import 'package:flutter_screenutil/screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;


  String currentType = 'pop';
  @override
  // TODO: implement wantKeepAlive保持顶部栏的切换的状态保持
  bool get wantKeepAlive => true;

  Map goods = {
    'pop': {'page': 1, 'list': []},
    'new': {'page': 1, 'list': []},
    'sell': {'page': 1, 'list': []},
  };

  bool showToTopBtn = false;

  void getHomeTypeGoods(String type) {
    getHomeGoods(type, this.goods[type]['page']).then((value) {
//      print(value);
      setState(() {
        this.goods[type]['list'].addAll((value['data']['list']).cast());
        this.goods[type]['page'] += 1;
      });
    });
  }

  @override
  // ignore: must_call_super
  void initState() {
    super.initState();
    getHomeTypeGoods('pop');
    getHomeTypeGoods('new');
    getHomeTypeGoods('sell');
    _tabController = new TabController(length: 3, vsync: this)..addListener(() {
      if(_tabController.indexIsChanging){
        switch(_tabController.index){
          case 0:
            setState(() {
              this.currentType = 'pop';
            });
            break;
          case 1:
            setState(() {
              this.currentType = 'new';
            });
            break;
          case 2:
            setState(() {
              this.currentType = 'sell';
            });
            break;
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Text('购物街'),
//          bottomOpacity: 1,
        bottom: TabBar(
          controller: this._tabController,
          tabs: <Widget>[
            Tab(
              text: '流行',
            ),
            Tab(
              text: '新款',
            ),
            Tab(
              text: '热卖',
            ),
          ],
        ),
      ),
    body:TabBarView(
        controller: this._tabController,
        children: <Widget>[
          TabPage(good: this.goods['pop'],type: 'pop',),
          TabPage(good: this.goods['new'],type: 'new',),
          TabPage(good: this.goods['sell'],type: 'sell',),
        ],
      ),

    );
  }



}
