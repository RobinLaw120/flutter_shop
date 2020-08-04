

import 'package:flutter/material.dart';

class GoodsList extends StatelessWidget{
  List goodsListData;
  String iid;

  GoodsList({Key key,this.goodsListData}):super(key: key);
  List<Widget> _getGoods(context){
    var tempList =  goodsListData.map((value){
          return InkWell(
            onTap: (){
//              print(value['iid']);
              Navigator.pushNamed(context, '/detail',arguments: {
                "iid": value['iid']
              });
            },
//            height: 250,
            child: Column(
              children: <Widget>[
                Image.network(value['show']['img'],fit: BoxFit.cover,),
                Wrap(
                  children: <Widget>[
                    Text(value['title'])
                  ],
                )
              ],
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
        primary: false,
        controller: ScrollController(keepScrollOffset: true),
        children: this._getGoods(context),
      );
  }

}