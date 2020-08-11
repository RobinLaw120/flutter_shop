import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shop/component/common/myPaint.dart';
import 'package:flutter_shop/component/content/bottomTab.dart';
import 'package:flutter_shop/pages/good_detail/child_detail/good_baseInfo.dart';
import 'package:flutter_shop/pages/good_detail/child_detail/show_detail.dart';
import 'package:flutter_shop/pages/good_detail/child_detail/store_info.dart';
import 'package:flutter_shop/pages/home_child/goods.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_shop/component/common/swiper.dart';
import 'package:flutter_screenutil/screenutil.dart';

class DetailPage extends StatefulWidget {
  final arguments;

  DetailPage({this.arguments});

  @override
  _DetailPageState createState() => new _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ScrollController _scrollController =
      new ScrollController(keepScrollOffset: true);

  int isSelectOrShowIndex = 0;
  Color titleColor = Colors.black;

  var recommends;

  bool showToTopBtn = false;

  bool isSelected1 = true;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;

  @override
  // ignore: must_call_super
  void initState() {
    print(widget.arguments['iid']);
    _scrollController.addListener(() {
      if (_scrollController.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_scrollController.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
      });
  }

  void selectGoods() {
    this.isSelected1 = true;
    this.isSelected2 = false;
    this.isSelected3 = false;
    this.isSelected4 = false;
  }

  void selectParams() {
    this.isSelected1 = false;
    this.isSelected2 = true;
    this.isSelected3 = false;
    this.isSelected4 = false;
  }

  void selectComments() {
    this.isSelected1 = false;
    this.isSelected2 = false;
    this.isSelected3 = true;
    this.isSelected4 = false;
  }

  void selectRecommends() {
    this.isSelected1 = false;
    this.isSelected2 = false;
    this.isSelected3 = false;
    this.isSelected4 = true;
  }

  List getTables(List tables){
    var tablesList = tables.map((values){
      return TableRow(children: getTablesRow(values),);
    });
    return tablesList.toList();
  }
  
  List getTablesRow(List rows){
    var rowList = rows.map((values){
      return SizedBox(
        height: 40,
        child: Text(values, style: TextStyle(fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true),),),
      );
    });
    return rowList.toList();
  }

  List getSetTables(List sets){
    var setList = sets.map((values){
      return TableRow(children: [
        SizedBox(
          height: 40,
          child: Text(values['key'], style: TextStyle(fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true),),),
        ),
        SizedBox(
          height: 40,
          child: Text(values['value'], overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true),color: Colors.pink),),
        ),

      ]);
    });
    return setList.toList();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 720, height: 1280, allowFontScaling: false);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        //top
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: InkWell(
                key: Key('goods'),
                onTap: () {
                  setState(() {
                    this.selectGoods();
                  });
                },
                child: Text(
                  '商品',
                  style: TextStyle(
                      fontSize: 16,
                      color: isSelected1 ? Colors.white : titleColor),
                ),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    this.selectParams();
                  });
                },
                key: Key('params'),
                child: Text(
                  '参数',
                  style: TextStyle(
                      fontSize: 16,
                      color: isSelected2 ? Colors.white : titleColor),
                ),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    this.selectComments();
                  });
                },
                key: Key('comments'),
                child: Text(
                  '评论',
                  style: TextStyle(
                      fontSize: 16,
                      color: isSelected3 ? Colors.white : titleColor),
                ),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    this.selectRecommends();
                  });
                },
                key: Key('recommend'),
                child: Text(
                  '推荐',
                  style: TextStyle(
                      fontSize: 16,
                      color: isSelected4 ? Colors.white : titleColor),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: getGoodsDeatilByIid(widget.arguments['iid']),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data['result'];
              return Container(
                width: ScreenUtil.screenWidth,
                child: ListView(
                  controller: this._scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  addAutomaticKeepAlives: true,
                  children: <Widget>[
                    //轮播图
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: SwiperDiy(
                        swiperDataList: data['itemInfo']['topImages'],
                      ),
                    ),
                    //商品基本信息
                    GoodBaseInfoPage(
                      data: data,
                    ),
                    //店铺详情
                    StoreInfoPage(
                      data: data,
                    ),
                    //商品展示详情
//                      Text('商品详情',style: TextStyle(fontSize: ScreenUtil().setSp(26, allowFontScalingSelf: true),),),
                    Container(
                      child: ShowDetailPage(
                        dataList: data['detailInfo']['detailImage'][0]['list'],
                      ),
                    ),
                    //商品参数
                    Container(
                      color: Colors.white,
                      child: Table(
                        children: getTables(data['itemParams']['rule']['tables'][0]),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Table(
                        columnWidths:{
                          0: FixedColumnWidth(ScreenUtil().setWidth(0)),
                          1: FixedColumnWidth(ScreenUtil().setWidth(380))
                        },
                        children: getSetTables(data['itemParams']['info']['set']),
                      ),
                    ),
                    Container(
                      child: FutureBuilder(
                        future: getDetailRecommend(),
                        builder: (context, snapshot){
                          if (snapshot.hasData){
                            var data = snapshot.data['data'];
                            return GoodsList(goodsListData: data['list'],);
                          }else{
                            return Center(
                              child: Text('正在加载。。。'),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('加载中。。。'),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomTabPage(),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          this._scrollController.animateTo(.0,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
      ),
    );
  }
}
