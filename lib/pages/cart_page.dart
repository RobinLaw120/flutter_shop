import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_shop/provider/CartProvider.dart';
import 'package:provide/provide.dart';


 class CartPage extends StatefulWidget {
   @override
   _CartPageState createState() => _CartPageState();
 }
 
 class _CartPageState extends State<CartPage>  with SingleTickerProviderStateMixin{


   ScrollController _scrollController =
   new ScrollController(keepScrollOffset: true);
   List<bool> boolList  = new List<bool>();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      for(int i =0; i < 1000; i++){
        boolList.add(false);
      }
    });


  }

   void itemChange(bool val, int index){
     setState(() {
       boolList[index] = val;
     });
   }


   @override
   Widget build(BuildContext context) {
     ScreenUtil.init(width: 720, height: 1280, allowFontScaling: false);
     return Scaffold(
       bottomNavigationBar: BottomAppBar(
         color: Colors.white30,
         child: Container(
           child: Text('结算')
         ),
       ),
       appBar: AppBar(
         backgroundColor: Colors.cyan,
         centerTitle: true,
         title: Text('我的购物车'),
       ),
       body: Provide<CartProvider>(
         builder: (BuildContext context, Widget child, CartProvider cartProvider){
           List cartList = (json.decode(cartProvider.cartString.toString()) as List).cast();
           if(cartList.length > 0){
             return Center(
               child: Container(
                     child: ListView.builder(
                       controller: _scrollController,
                       itemCount: cartList.length,
                       itemBuilder: (BuildContext context, int index){
                         return SizedBox(
                           height: ScreenUtil().setHeight(150),
                           child: Card(
                             elevation: 15.0,  //设置阴影
                             shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
                             child: CheckboxListTile(
                               activeColor: Colors.blue,
                               selected: this.boolList[index],
                               controlAffinity: ListTileControlAffinity.leading,
                               key: Key(cartList[index]['goodId']),
                               title: Text(cartList[index]['goodName'],style: TextStyle(fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true)),overflow: TextOverflow.ellipsis,),
                               subtitle: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: <Widget>[
                                   Text('￥' + cartList[index]['price'], style: TextStyle(fontSize: ScreenUtil().setSp(22, allowFontScalingSelf: true)),),
                                   Text('数量: ' + 'x ' +cartList[index]['count'].toString(), style: TextStyle(fontSize: ScreenUtil().setSp(22, allowFontScalingSelf: true))),
                                 ],
                               ),
                               value: this.boolList[index],
                               onChanged: (bool val){
                                 itemChange(val, index);
                               },
                               secondary: InkWell(
                                 onTap: (){
                                   Navigator.pushNamed(context, '/detail',arguments: {
                                     "iid": cartList[index]['goodId']
                                   });
                                 },
                                 child: Image.network('https:' + cartList[index]['image'], fit: BoxFit.cover,),
                               ),
                             ),
                           ),
                         );
                       },
                     ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Container(color: Colors.green,child: Text('nidaye'),),
//                     )
//                   ],
               ),
             );
           }else{
             return Center(child: Text(''),);
           }
         },
       ),
     );
   }
 }
