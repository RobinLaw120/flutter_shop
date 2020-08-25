import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier{
  String cartString = "[]";
  save(goodId,goodName,count,price,image) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    //判断cartString是否为空
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    //把获取的值转成List
    List<Map> tempList = (temp as List).cast();
    //声明变量，判断是否已经存在此商品
    var isHave = false;
    int index = 0;//循环索引
    //同样商品数量加一
    tempList.forEach((element) {
      if(element['goodId'] == goodId){
        tempList[index]['count'] = element['count'] + 1;
        isHave = true;
      }
      index++;
    });
    if(!isHave){
      tempList.add({
        'goodId': goodId,
        'goodName': goodName,
        'count': count,
        'price': price,
        'image': image
      });
    }
    //把字符串进行encode操作
    cartString = json.encode(tempList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);//持久化操作
    notifyListeners();
  }

  remove(goodId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var str = prefs.getString('cartInfo');
    if(str != null){
      var temp = json.decode(str.toString());
      List<Map> tempList = (temp as List).cast();
      var listNew = [];
      tempList.forEach((element) {
        if(element['goodId'] != goodId){
          listNew.add(element);
        }
      });
      cartString = json.encode(listNew).toString();
      print('购买之后，在购物车中删除该商品：如下');
      print(cartString);
      prefs.setString('cartInfo', cartString);
    }
    notifyListeners();
  }

//   getCartList() async{
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    cartString = prefs.getString('cartInfo');
//    cartList = [];
//    if(cartList == null){
//      cartList = [];
//    }else{
//      List tempList = (json.decode(cartList.toString()) as List).cast();
//      tempList.forEach((element) {
//        cartList.add(element);
//      });
//    }
////    notifyListeners();
//  }
}
