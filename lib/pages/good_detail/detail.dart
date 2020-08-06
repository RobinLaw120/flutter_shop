import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shop/component/common/myPaint.dart';
import 'package:flutter_shop/pages/good_detail/child_detail/good_baseInfo.dart';
import 'package:flutter_shop/pages/good_detail/child_detail/show_detail.dart';
import 'package:flutter_shop/pages/good_detail/child_detail/store_info.dart';
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


  bool isSelected1 = true;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;

  @override
  // ignore: must_call_super
  void initState() {
    print(widget.arguments['iid']);
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



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1334, allowFontScaling: false);
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
                child: Scrollbar(
                  controller: this._scrollController,
                  child: ListView(
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
                      GoodBaseInfoPage(data: data,),
                      //店铺详情
                      StoreInfoPage(data: data,),
                      //商品展示详情
//                      Text('商品详情',style: TextStyle(fontSize: ScreenUtil().setSp(26, allowFontScalingSelf: true),),),
                      Container(
                        child: ShowDetailPage(dataList: data['detailInfo']['detailImage'][0]['list'],),
                      ),
                      Container(
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('尺码')),
                            DataColumn(label: Text('S')),
                            DataColumn(label: Text('M')),
                            DataColumn(label: Text('L'))
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                DataCell(Text('胸围')),
                                DataCell(Text('100')),
                                DataCell(Text('104')),
                                DataCell(Text('108')),
                              ]
                            )
                          ],
                        ),
                      )
                    ],
                  ),
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
    );
  }
}
