import 'package:flutter/material.dart';
import 'package:flutter_shop/routes/Routes.dart';
import './pages/index_page.dart';

void main() => runApp(MyApp());


//呵呵呵
//hahaha
//大哥测试
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '购物街',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(
          primaryColor: Colors.cyan,
        ),
        home: IndexPage(),
      ),
    );
  }
}
