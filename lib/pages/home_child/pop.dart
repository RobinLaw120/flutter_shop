import 'package:flutter/material.dart';
import 'package:flutter_shop/component/content/topView.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'goods.dart';

class PopPage extends StatefulWidget {
  @override
  _PopPageState createState() => _PopPageState();
}

class _PopPageState extends State<PopPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  bool showToTopBtn = false;

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
    getHomeTypeGoods('pop');
    _scrollController.addListener(() {
      print(_scrollController.offset); //打印滚动位置
      if (_scrollController.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_scrollController.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          getHomeTypeGoods('pop');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
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
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          setState(() {
            this.goods['list'].removeRange(
                30, this.goods['list'].length);
            this.goods['page'] = 1;
          });
          this._scrollController.animateTo(.0,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
      ),
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}