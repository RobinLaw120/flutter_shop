import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
 import 'package:flutter_screenutil/screenutil.dart';


class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(width: 750, height: 1334, allowFontScaling: false);
    return Container(
      height: 300,
      child: new Swiper(
        itemCount: this.swiperDataList.length,
//        pagination: SwiperPagination(margin: EdgeInsets.all(10)),
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return swiperDataList[index].runtimeType != String ? Container(
            width: ScreenUtil.screenWidth,
            child: Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.fitWidth,
          ),) : Image.network("https:" + swiperDataList[index], fit: BoxFit.cover,);
        },
      ),
    );
  }
}
