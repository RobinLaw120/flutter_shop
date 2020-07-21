import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shop/component/common/myPaint.dart';
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

  List<Widget> getService(List services){
    var listServices =  services.map((value){
      return Text(value, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey),);
    });
    return listServices.toList();
  }

  List<Widget> getDelivery(List deliveries){
    var listDeliveries = deliveries.map((value){
//      print(value);
      return value['icon'] != null && value['name'] != null ? Container(
        width: ScreenUtil.screenWidth/4,
//          decoration: BoxDecoration(
//            color: Colors.redAccent,
//            border: Border.all(
//              color: Colors.red,
//            )),
        child: ListTile(
//          leading: Image.network('https:' + value['icon'],width: 15, height: 15, fit: BoxFit.cover,),
          title: Text(value['name'], style: TextStyle(fontSize: ScreenUtil().setSp(20, allowFontScalingSelf: true)), overflow: TextOverflow.fade,),
        ),
      ) : Text('');
    });
    return listDeliveries.toList();
  }

  @override
  // ignore: must_call_super
  void initState() {}

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
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SwiperDiy(
                          swiperDataList: data['detailInfo']['detailImage'][0]
                              ['list'],
                        ),
                      ),//轮播图
                      Card(

                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        shadowColor: Colors.grey,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                data['itemInfo']['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(40, allowFontScalingSelf: true),
                                ),
                              ),
                            ),
                            ListTile(

                              title: Row(

                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    data['itemInfo']['price'],
                                    style: TextStyle(
                                        color: Colors.pinkAccent, fontSize: ScreenUtil().setSp(40, allowFontScalingSelf: true)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(data['itemInfo']['highPrice'],
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
                                        color: Colors.grey, decoration: TextDecoration.lineThrough, decorationColor: Colors.black,),),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  data['itemInfo']['discountDesc'] != ""
                                      ? Container(
                                    width: ScreenUtil().setWidth(150),
//                                    height: 30,
                                    child: Text(
                                      data['itemInfo']['discountDesc'],
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      border: Border.all(
                                        color: Colors.red,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(100),
                                    ),
                                  )
                                      : Text(''),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: getService(data['columns']),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              child: CustomPaint(
                                size: Size(550,10),
                                painter: MyPaint(positionX: 550, painterWidth: 1, lineColor: Colors.black38),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              width: ScreenUtil.screenWidth,
                                child: Row(
                                  children: getDelivery(data['shopInfo']['services']),
                                ),
                            ),
                          ],
                        ),
                      ),//基本信息
                      Card(
//                        color: Colors.cyan,
                        margin: EdgeInsets.fromLTRB(0,0, 0, 5),
                        shadowColor: Colors.grey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage('https:' + data['shopInfo']['shopLogo']),
                                ),
                                title: Text(data['shopInfo']['name']),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(data['shopInfo']['cSells'].toString(), style: TextStyle(fontSize: 24, color: Colors.orange),),
                                    SizedBox(height: 10,),
                                    Text('总销量', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 22),)
                                  ],
                                ),//总销量
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(data['shopInfo']['cGoods'].toString(), style: TextStyle(fontSize: 24, color: Colors.deepOrange),),
                                    SizedBox(height: 10,),
                                    Text('全部宝贝', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 22),)
                                  ],
                                ),
                                Container(
                                  child: CustomPaint(
                                    size: Size(10,100),
                                    painter: MyPaint(positionY:100, painterWidth: 1, lineColor: Colors.grey, positionX: 0),
                                  ),
                                )
                                //全部宝贝
                              ],
                            )
                          ],
                        ),
                      ),
                      //基本商品详情
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
