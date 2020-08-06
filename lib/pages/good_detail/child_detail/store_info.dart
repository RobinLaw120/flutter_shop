import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_shop/component/common/myPaint.dart';

class StoreInfoPage extends StatelessWidget{
  var data;

  StoreInfoPage({this.data});

  List<Widget> getScore(List scores){
    var listScore = scores.map((value){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(value['name'],style: TextStyle(fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true)),),
          Text(value['score'].toString(), style: TextStyle(color: value['isBetter'] ? Colors.red : Colors.green),),
          Text(value['isBetter'] ? '高' : '低', style: TextStyle(backgroundColor: value['isBetter'] ? Colors.red : Colors.green, color: Colors.white),)
        ],
      );
    });
    return listScore.toList();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0,0, 0, 5),
      shadowColor: Colors.grey,
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(width: 20,),
                ClipOval(
                  child: Image.network('https:' + data['shopInfo']['shopLogo'],fit: BoxFit.fill,width: ScreenUtil().setWidth(80),height: ScreenUtil().setHeight(80),),
                ),
                SizedBox(width: 10,),
                Text(data['shopInfo']['name'],style: TextStyle(fontSize: ScreenUtil().setSp(24,allowFontScalingSelf: true)),),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(data['shopInfo']['cSells'].toString(), style: TextStyle(fontSize: 24, color: Colors.orange),),
                    Text('总销量', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 22),)
                  ],
                ),
              ),//总销量
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(data['shopInfo']['cGoods'].toString(), style: TextStyle(fontSize: 24, color: Colors.deepOrange),),
                    Text('全部宝贝', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 22),)
                  ],
                ),
              ),//全部宝贝
              Container(
                child: CustomPaint(
                  size: Size(30,80),
                  painter: MyPaint(positionY:80, painterWidth: 1, lineColor: Colors.grey, positionX: 0),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(200),
                height: ScreenUtil().setHeight(200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: getScore(data['shopInfo']['score']),
                ),
              )
            ],
          ),
          Container(
            width: 200,
            child: RaisedButton(
              color: Colors.grey,
              textColor: Colors.black,
//              elevation: 10,
              child: Text('进店逛逛',style: TextStyle(fontSize: ScreenUtil().setSp(23, allowFontScalingSelf: true)),),
              onPressed: (){},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
            ),
          )
        ],

      ),
    );
  }

}