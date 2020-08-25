
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/good_detail/detail.dart';

import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/index_page.dart';


final routes = {
  '/home': (context) => HomePage(),
  '/detail': (context, {arguments}) => DetailPage(arguments: arguments,),
  '/index': (context) => IndexPage(),
};

// ignore: top_level_function_literal_block
var onGenerateRoute=(RouteSettings settings){
  //统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments)
      );
      return route;
    } else {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context)
      );
      return route;
    }
  }
  return null;
};