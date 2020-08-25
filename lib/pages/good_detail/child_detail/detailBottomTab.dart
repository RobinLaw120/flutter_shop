import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_shop/provider/CartProvider.dart';
import 'package:provide/provide.dart';

class BottomTabPage extends StatelessWidget{
  var goodId,goodName,count,price,image;

  BottomTabPage({this.goodId, this.goodName, this.image, this.price, this.count = 1});


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 720, height: 1280, allowFontScaling: false);
    return Container(
      decoration:BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(00.0, 15.0), //阴影xy轴偏移量
                blurRadius: 15.0, //阴影模糊程度
                spreadRadius: 1.0 //阴影扩散程度
            )
          ]),
      height: ScreenUtil().setHeight(80),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white54,
            ),
            width: ScreenUtil.screenWidth * 0.4,
            height: ScreenUtil().setHeight(80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: (){},
                  child: Image.asset('images/server.png', width: ScreenUtil().setWidth(60),height: ScreenUtil().setHeight(60),fit: BoxFit.cover,),
                ),
                InkWell(
                  onTap: (){},
                  child: Image.asset('images/store.png', width: ScreenUtil().setWidth(60),height: ScreenUtil().setHeight(60),fit: BoxFit.cover,),
                ),
                InkWell(
                  onTap: (){},
                  child: Image.asset('images/collection.png', width: ScreenUtil().setWidth(60),height: ScreenUtil().setHeight(60),fit: BoxFit.cover,),
                ),
              ],
            ),
          ),
          Container(
//            color: Colors.orange,
            width: ScreenUtil.screenWidth * 0.6,
            child: Row(
//              direction: Axis.horizontal,
              children: <Widget>[

                Container(
                  height: ScreenUtil().setHeight(80),
//                  color: Colors.cyan,
                  width: ScreenUtil.screenWidth * 0.6 * 0.5,
                  child: RaisedButton(
                    color: Colors.cyan,
                    child: Text('加入购物车', style: TextStyle(fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true)),),
                    onPressed: () async{
                      await Provide.value<CartProvider>(context).save(goodId, goodName, count, price, image);
                    },
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(80),
//                  color: Colors.redAccent,
                  width: ScreenUtil.screenWidth * 0.6 * 0.5,
                  child: RaisedButton(
                    color: Colors.redAccent,
                    child: Text('购买', style: TextStyle(fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true), color: Colors.white),),
                    onPressed: () async{
                      await Provide.value<CartProvider>(context).remove(goodId);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}