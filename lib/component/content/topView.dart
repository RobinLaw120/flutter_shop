import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_shop/component/common/swiper.dart';
import 'package:flutter_shop/component/content/recommend.dart';
import 'package:flutter_shop/service/service_method.dart';

class TopViewPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            List swiper =
            (data['data']['banner']['list'] as List).cast();
            List recommend =
            (data['data']['recommend']['list'] as List).cast();
            return Column(
//                      crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SwiperDiy(
                    swiperDataList: swiper,
                  ),
                ),
                Container(
                  width: ScreenUtil.screenWidth,
                  child: RecommendNav(recommendNav: recommend),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

}