import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './home_page.dart';
import './category_page.dart';
import './cart_page.dart';
import './member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {


  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
      ),
      BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
      ),
      BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
      ),
      BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('个人中心'),
      ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: bottomTabs,
          onTap: (index){
            setState(() {
              currentIndex = index;
              currentPage = tabBodies[currentIndex];
            });
          },
        ),
        //保持底部导航栏切换的状态
        body: IndexedStack(
          index: this.currentIndex,
          children: tabBodies,
        ),
      ),
    );
  }
}