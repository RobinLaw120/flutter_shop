import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';

Dio dio = new Dio();
Response response;
//获取首页内容
Future getHomePageContent() async {
  try {

    // print(servicePath['homePageContent']);
    // dio.options.contentType = ContentType.parse("application/json") as String;
    response = await dio.get(servicePath['homePageContent']);
    if (response.statusCode == 200) {
      // print(response);
      return response.data;
    } else {
      throw Exception('接口出现异常');
    }
  } catch (e) {
    return print('Erro');
  }
}

Future getHomeGoods(String type, int page) async {
  try {
//    Response response;
    var params = {"type": type, "page": page};
    response =
        await dio.get(servicePath['homePageGoods'], queryParameters: params);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口出现异常');
    }
  } catch (e) {
    return print('Erro');
  }
}

Future getGoodsDeatilByIid(String iid) async{
  try{
    var params = {'iid': iid};
    response = await dio.get(servicePath['goodsDetail'], queryParameters: params);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口出现异常');
    }
  }catch(e){
    return print('error');
  }
}
