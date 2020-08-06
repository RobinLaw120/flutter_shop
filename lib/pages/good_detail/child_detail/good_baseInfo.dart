import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_shop/component/common/myPaint.dart';

// ignore: must_be_immutable
class GoodBaseInfoPage extends StatelessWidget{
  var data;
  GoodBaseInfoPage({this.data = ""});


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
        width: ScreenUtil().setWidth(165),
        child: ListTile(
//          leading: Image.network('https:' + value['icon'],width: 15, height: 15, fit: BoxFit.cover,),
          title: Text(value['name'], style: TextStyle(fontSize: ScreenUtil().setSp(16, allowFontScalingSelf: true)), overflow: TextOverflow.fade,),
        ),
      ) : Text('');
    });
    return listDeliveries.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      shadowColor: Colors.grey,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              data['itemInfo']['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(32, allowFontScalingSelf: true),
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
                      color: Colors.pinkAccent, fontSize: ScreenUtil().setSp(32, allowFontScalingSelf: true)),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(data['itemInfo']['highPrice'],
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(28, allowFontScalingSelf: true),
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
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            width: ScreenUtil.screenWidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: getDelivery(data['shopInfo']['services']),
            ),
          ),
        ],
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}