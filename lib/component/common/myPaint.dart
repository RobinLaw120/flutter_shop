import 'package:flutter/material.dart';

class MyPaint extends CustomPainter{


  double positionX;
  double painterWidth;
  Color lineColor;
  double positionY;

  MyPaint({this.positionX = 100, this.positionY = 0,this.painterWidth = 5, this.lineColor = Colors.black});

  Paint _paint = Paint()
    ..color = Colors.grey
    ..isAntiAlias = true;
  Path _path = Path();

//  Offset p1 = Offset(0, 0);
//  Offset p2 = Offset(0,60);


  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    _paint.style = PaintingStyle.stroke;
    _paint.color = this.lineColor;
    _paint.strokeWidth = this.painterWidth;
    _path.relativeLineTo(this.positionX, this.positionY);
    _path.close();

    canvas.drawPath(_path, _paint);
//    canvas.drawLine(p1, p2, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

}