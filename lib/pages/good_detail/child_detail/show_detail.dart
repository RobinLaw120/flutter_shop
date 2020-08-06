import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShowDetailPage extends StatelessWidget{

  var dataList;

  ShowDetailPage({this.dataList});
  
  
  List<Widget> showList(List detailImages){
    var imageList = detailImages.map((value){
      return Container(
        child: Image.network('https:' + value, fit: BoxFit.cover,),
        padding: EdgeInsets.all(5),
      );
    });
    
    return imageList.toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: showList(this.dataList),
    );
  }

}