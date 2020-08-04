import 'package:flutter/material.dart';

class RecommendNav extends StatelessWidget {
  final List recommendNav;

  RecommendNav({Key key, this.recommendNav}) : super(key: key);

  List<Widget> _getListData() {
    //tempList=('xxx','xxx')
    var tempList = recommendNav.map((value) {
      // print(value);
      return Container(
//          width: 600,
          child: Column(
            children: <Widget>[
              // Image.network(value['image'],fit: BoxFit.fill,),
              Container(
                width: 80,
                height: 80,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    value['image'],
                  ),
                ),
              ),
              Text(value['title']),
            ],
          ));
    });
    return tempList.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: this._getListData(),
      ),
    );
  }
}
