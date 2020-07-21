import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_shop/component/common/swiper.dart';
import '../service/service_method.dart';
import '../component/content/recommend.dart';
import '../pages/home_child/goods.dart';

import 'package:flutter_screenutil/screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

//  int currentIndex = 0;
  String currentType = 'pop';
  GlobalKey bannerAndRecommend = new GlobalKey();

  double scrollToOffset;
//  int currentPage = 1;
//  List typeList = [
//      {'page':1, 'list': [], 'type': 'pop'},
//      {'page':1, 'list': [], 'type': 'new'},
//      {'page':1, 'list': [], 'type': 'sell'},
//  ];
  Map goods = {
    'pop': {'page': 1, 'list': []},
    'new': {'page': 1, 'list': []},
    'sell': {'page': 1, 'list': []},
  };

  ScrollController _scrollController =
      new ScrollController(keepScrollOffset: true);
  bool showToTopBtn = false;

  @override
  // TODO: implement wantKeepAlive保持顶部栏的切换的状态保持
  bool get wantKeepAlive => true;

  void getHomeTypeGoods(String type) {
    getHomeGoods(type, this.goods[type]['page']).then((value) {
//      print(value);
      this.goods[type]['list'].addAll((value['data']['list']).cast());
      this.goods[type]['page'] += 1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    getHomeTypeGoods('pop');
    getHomeTypeGoods('new');
    getHomeTypeGoods('sell');
//    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//      RenderBox box = bannerAndRecommend.currentContext.findRenderObject();
//      if(box != null){
//        print(box.localToGlobal(Offset.zero).dy);
//        this.scrollToOffset = box.localToGlobal(Offset.zero).dy;
//      }
////      setState(() {
////        this.scrollToOffset = box.localToGlobal(Offset.zero).dy + box.size.height;
////      });
//    });
    _tabController = new TabController(length: this.goods.length, vsync: this);
    _scrollController.addListener(() {
//      print(_scrollController.offset); //打印滚动位置
      if (_scrollController.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_scrollController.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          getHomeTypeGoods(this.currentType);
        });
      }
    });
  }


  @override
  void didUpdateWidget(HomePage oldWidget) {


    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(width: 750, height: 1334, allowFontScaling: false);
    // print(swiperBanners);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Text('购物街'),
//          bottomOpacity: 1,
        bottom: TabBar(
          onTap: (index) {
//            if(_scrollController.offset > this.scrollToOffset){
//              this._scrollController.animateTo(this.scrollToOffset,
//                duration: Duration(milliseconds: 100), curve: Curves.ease);
//            }
//            this._scrollController.animateTo(this.scrollToOffset,
//                duration: Duration(milliseconds: 500), curve: Curves.ease);
            setState(() {
              switch (index) {
                case 0:
                  this.currentType = 'pop';
                  break;
                case 1:
                  this.currentType = 'new';
//                  print(bannerAndRecommend.currentContext.size.height);
                  break;
                case 2:
                  this.currentType = 'sell';
                  break;
              }
            });
          },
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
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.all(0),
          reverse: false,
          physics: AlwaysScrollableScrollPhysics(),
          addAutomaticKeepAlives: true,
          controller: this._scrollController,
          children: <Widget>[
            Container(
              child: FutureBuilder(
                future: getHomePageContent(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    List swiper =
                        (data['data']['banner']['list'] as List).cast();
                    List recommend =
                        (data['data']['recommend']['list'] as List).cast();
                    return Column(
//                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: SwiperDiy(
                            swiperDataList: swiper,
                          ),
                        ),
//                        SizedBox(
//                          height: 20,
//                        ),
                        Container(
                          width: ScreenUtil.screenWidth,
                          child: RecommendNav(recommendNav: recommend),
                        )
                      ],
                    );
                  } else {
                    return Center(
                      child: Text('加载中。。。'),
                    );
                  }
                },
              ),
            ), //轮播图和推荐
            SizedBox(
              height: 10,
            ),
//            TabBarView(
//              controller: this._tabController,
//              children: <Widget>[
//                GoodsList(
//                  goodsListData: this.goods['pop']['list'],
//                ),
//                GoodsList(
//                  goodsListData: this.goods['new']['list'],
//                ),
//                GoodsList(
//                  goodsListData: this.goods['sell']['list'],
//                ),
//              ],
//            ),
            GoodsList(
              key: bannerAndRecommend,
              goodsListData: this.goods[this.currentType]['list'],
            ),
          ],
        ),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                setState(() {
                  this.goods[this.currentType]['list'].removeRange(
                      30, this.goods[this.currentType]['list'].length);
                  this.goods[currentType]['page'] = 1;
                });

                this._scrollController.animateTo(.0,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              },
            ),
    );
  }



}
