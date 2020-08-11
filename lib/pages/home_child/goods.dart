

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class GoodsList extends StatelessWidget{
  List goodsListData;
  String iid;

  GoodsList({Key key,this.goodsListData}):super(key: key);


  List<Widget> _getGoods(context){
    var tempList =  goodsListData.map((value){
          return Container(
            child: InkWell(
              onTap: (){
//              print(value['iid']);
                Navigator.pushNamed(context, '/detail',arguments: {
                  "iid": value['iid']
                });
              },
              child: Column(
                children: <Widget>[
                  value['show'] != null && value['show']['img'] != null? Image.network(value['show']['img'],fit: BoxFit.cover,) : Image.network(value['image'],fit: BoxFit.cover,),
                  Wrap(
                    children: <Widget>[
                      Text(value['title'], overflow: TextOverflow.ellipsis,)
                    ],
                  )
                ],
              ),
            ),
          );
    });
    return tempList.toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(

        padding: EdgeInsets.fromLTRB(10, 0, 10,  0),
        shrinkWrap: true,
        crossAxisSpacing: 10.0,//水平间间距
        mainAxisSpacing: 10.0,//垂直间间距
        crossAxisCount: 2,//一行的数量
        childAspectRatio: 0.5,//调整宽高比例
        physics: NeverScrollableScrollPhysics(),
        controller: ScrollController(keepScrollOffset: true),
        children: this._getGoods(context),
      );
  }

}