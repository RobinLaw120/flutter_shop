import 'package:flutter/material.dart';
import 'package:flutter_shop/component/content/topView.dart';
import 'package:flutter_shop/service/service_method.dart';

import 'goods.dart';

class TabPage extends StatefulWidget {
  var good;
  String type;

  TabPage({this.good, this.type});

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ScrollController _scrollController =
      new ScrollController(keepScrollOffset: true);

  bool showToTopBtn = false;

  void getHomeTypeGoods() {
    getHomeGoods(widget.type, widget.good['page']).then((value) {
      setState(() {
        widget.good['list'].addAll((value['data']['list']).cast());
        widget.good['page'] += 1;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
//      print(_scrollController.offset); //打印滚动位置
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
          getHomeTypeGoods();
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
              goodsListData: widget.good['list'],
            ),
          ],
        ),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
//        FloatingActionButton中的tag 有冲突。
              heroTag: widget.type,
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                setState(() {
                  widget.good['list']
                      .removeRange(30, widget.good['list'].length);
                  widget.good['page'] = 1;
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
