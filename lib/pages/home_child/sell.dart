import 'package:flutter/material.dart';
import 'package:flutter_shop/component/content/topView.dart';
import 'package:flutter_shop/service/service_method.dart';

import 'goods.dart';



class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage>  with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  Map goods = {
    'page': 1,
    'list': []
  };

  ScrollController _scrollController =
  new ScrollController(keepScrollOffset: true);

  void getHomeTypeGoods(String type) {
    getHomeGoods(type, this.goods['page']).then((value) {
//      print(value);
      setState(() {
        this.goods['list'].addAll((value['data']['list']).cast());
        this.goods['page'] += 1;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getHomeTypeGoods('sell');
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: ListView(
          padding: EdgeInsets.all(0),
          reverse: false,
          physics: AlwaysScrollableScrollPhysics(),
          addAutomaticKeepAlives: true,
          controller: this._scrollController,
          children: <Widget>[
            TopViewPage(),
            SizedBox(
              height: 10,
            ),
            GoodsList(
//              key: bannerAndRecommend,
              goodsListData: this.goods['list'],
            ),
          ],
        ),

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}