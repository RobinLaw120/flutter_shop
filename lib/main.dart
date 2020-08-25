import 'package:flutter/material.dart';
import 'package:flutter_shop/component/common/loginPage.dart';
import 'package:flutter_shop/routes/Routes.dart';
import 'package:provide/provide.dart';
import './pages/index_page.dart';
import './provider/CartProvider.dart';


void main(){
  var cartProvide = CartProvider();
  var providers = Providers();

  providers
  ..provide(Provider<CartProvider>.value(cartProvide));
  runApp(ProviderNode(child: MyApp(), providers: providers,));
}
//
//void main() => runApp(MyApp());

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
        home: LoginPage(),
      ),
    );
  }
}
