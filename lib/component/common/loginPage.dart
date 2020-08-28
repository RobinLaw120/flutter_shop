
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';


//class AnimatedLogo extends AnimatedWidget{
//  AnimatedLogo({Key key, Animation<double> animation}) : super(key:key, listenable: animation);
//  @override
//  Widget build(BuildContext context) {
//    final Animation<double> animation = listenable;
//    return SizedBox(
//      height: ScreenUtil().setHeight(animation.value),
//      width: ScreenUtil().setHeight(animation.value),
//      child: Image(
//        image: AssetImage("images/logo.png"),fit: BoxFit.cover,
//      ),
//    );
//  }
//
//}

bool _first = true;

class GrowTrasition extends StatelessWidget{
  final Widget child;
  final Animation<double> animation;

  GrowTrasition({this.child,this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child: child,//构造函数传入
        builder: (BuildContext context, Widget child){
          return Container(
            height: ScreenUtil().setHeight(animation.value),
            width: ScreenUtil().setWidth(animation.value),
            child: child,
          );
        },
    );
  }

}

class AnimatedLogo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage("images/logo.png"),fit: BoxFit.cover,
      ),
//      child: AnimatedPhysicalModel(
//        duration: Duration(milliseconds: 500),
//        curve: Curves.fastOutSlowIn,
//        elevation: _first ? 0 : 4.0,
//        shape: BoxShape.circle,
//        shadowColor: Colors.grey,
//        color: Colors.transparent,
//        borderRadius: _first
//          ? BorderRadius.all(Radius.circular(0))
//          : BorderRadius.all(Radius.circular(8)),
//        child: Image(
//          image: AssetImage("images/logo.png"),fit: BoxFit.cover,
//        ),
//      ),
    );
  }

}


class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }

}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  Animation<double> _animation;
  AnimationController _animationController;

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _verCodeController = TextEditingController();
  Widget getLoginComp(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GrowTrasition(child: AnimatedLogo(), animation: _animation,),
//        AnimatedLogo(animation: _animation,),
//        SizedBox(
//          height: ScreenUtil().setHeight(_animation.value),
//          width: ScreenUtil().setHeight(_animation.value),
//          child: Image(
//            image: AssetImage("images/logo.png"),fit: BoxFit.cover,
//          ),
//        ),
        TextField(
          controller: _userNameController,
          decoration: InputDecoration(
            hintText: "手机号",
            prefixIcon: Icon(Icons.perm_identity),
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[0-9]")),
          ],
        ),
        SizedBox(height: ScreenUtil().setHeight(20),),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "密码",
            prefixIcon: Icon(Icons.lock_outline),
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          obscureText: true,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        SizedBox(
          width: double.infinity,
          height: ScreenUtil().setHeight(70),
          child: FlatButton(
            color: Colors.cyan,
            colorBrightness: Brightness.dark,
            child: Text("登录",style: TextStyle(fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true)),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: (){
              //模拟登录成功之后
              Navigator.pushNamed(context, '/index');
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              color: Colors.transparent,
              child: Text('忘记密码？', style: TextStyle(fontSize: ScreenUtil().setSp(20, allowFontScalingSelf: true), color: Colors.white),),
              onPressed: (){

              },
            ),
            FlatButton(
              color: Colors.transparent,
              child: Text('注册',style: TextStyle(fontSize: ScreenUtil().setSp(20, allowFontScalingSelf: true), color: Colors.cyan),),
              onPressed: (){

              },
            )
          ],
        ),
        Divider(),
        Text('第三方登录', style: TextStyle(fontSize: ScreenUtil().setSp(16, allowFontScalingSelf: true), color: Colors.grey),),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              shape: CircleBorder(
                side: BorderSide(
                  color: Colors.transparent,
                  style: BorderStyle.none
                )
              ),
              child: Image(
                image: AssetImage("images/wechatIcon.png"),fit: BoxFit.contain,width: ScreenUtil().setWidth(80),height: ScreenUtil().setHeight(80),
              ),
              onPressed: (){

              },
            ),
            FlatButton(
              shape: CircleBorder(
                  side: BorderSide(
                      color: Colors.transparent,
                      style: BorderStyle.none
                  )
              ),
              child: Image(
                image: AssetImage("images/taobao.png"),fit: BoxFit.contain,width: ScreenUtil().setWidth(80),height: ScreenUtil().setHeight(80),
              ),
              onPressed: (){

              },
            ),
            FlatButton(
              shape: CircleBorder(
                  side: BorderSide(
                      color: Colors.transparent,
                      style: BorderStyle.none
                  )
              ),
              child: Image(
                image: AssetImage("images/alipayIcon.png"),fit: BoxFit.contain,width: ScreenUtil().setWidth(80),height: ScreenUtil().setHeight(80),
              ),
              onPressed: (){

              },
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 720, height: 1280, allowFontScaling: false);
    
    // TODO: implement build
    return new Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.jpg'),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color.fromARGB(150, 255, 255, 255),
        body: Container(
          padding: EdgeInsets.all(ScreenUtil().setWidth(60)),
          child: getLoginComp(),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000), vsync: this
    );
    //vurveAnimation继承了AnimationController
    final CurvedAnimation curve = new CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animation = new Tween(begin:0.0, end: 200.0 ).animate(curve)
    ..addListener(() {
      setState(() {

      });
    })
//      监听动画状态
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _first = false;
      }
    });
    _animationController.forward();
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }


}