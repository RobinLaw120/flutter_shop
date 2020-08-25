import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }

}

class _LoginPageState extends State<LoginPage>{
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _verCodeController = TextEditingController();

  Widget getLoginComp(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: ScreenUtil().setHeight(200),
          width: ScreenUtil().setHeight(200),
          child: Image(
            image: AssetImage("images/logo.png"),fit: BoxFit.cover,
          ),
        ),
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

}