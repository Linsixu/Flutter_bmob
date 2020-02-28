import 'package:flutter/material.dart';
import 'package:flutter_bmob/model/LoginUserModel.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _RegisterState();
  }
}

class _RegisterState extends State<RegisterPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  TextEditingController _againController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _childNameController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<LoginUserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true, //开启自动校验
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/music_logo.png',
                  width: 100, height: 100, alignment: Alignment.center),
              TextFormField(
                  autofocus: true,
                  controller: _unameController,
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "手机或者邮箱",
                      labelStyle: _generateTextStyle(),
                      hintStyle: _generateTextStyle(),
                      icon: Icon(Icons.person, size: 25)),
                  // 校验用户名
                  validator: (v) {
                    return v.trim().length > 0 ? null : "用户名不能为空";
                  }),
              TextFormField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      labelStyle: _generateTextStyle(),
                      hintStyle: _generateTextStyle(),
                      icon: Icon(Icons.lock, size: 25)),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v.trim().length > 5 ? null : "密码不能少于6位";
                  }),
              TextFormField(
                  controller: _againController,
                  decoration: InputDecoration(
                      labelText: "再次输入密码",
                      hintText: "为了不让您输错密码",
                      labelStyle: _generateTextStyle(),
                      hintStyle: _generateTextStyle(),
                      icon: Icon(Icons.lock, size: 25)),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return _againController.text == _pwdController.text
                        ? null
                        : "两次输入密码不同";
                  }),
              TextFormField(
                  controller: _childNameController,
                  decoration: InputDecoration(
                      labelText: "子女姓名",
                      hintText: "您子女的姓名",
                      labelStyle: _generateTextStyle(),
                      hintStyle: _generateTextStyle(),
                      icon: Icon(Icons.child_care, size: 25)),
                  obscureText: false,
                  // 校验用户名
                  validator: (v) {
                    return v.trim().length > 0 ? null : "子女名字不能为空";
                  }),
              TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      labelText: "手机号码",
                      hintText: "为了方便联系您",
                      labelStyle: _generateTextStyle(),
                      hintStyle: _generateTextStyle(),
                      icon: Icon(Icons.phone, size: 25)),
                  obscureText: false,
                  // 校验用户名
                  validator: (v) {
                    return _isPhoneValid(_phoneController.text)
                        ? null
                        : "输入手机号码不正确";
                  }),
              // 注册
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("注册"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。
                          if ((_formKey.currentState as FormState).validate()) {
                            //验证通过提交数据
                            _currentUser.registerParentModel(
                                _unameController.text,
                                _pwdController.text,
                                _childNameController.text,
                                _phoneController.text);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  TextStyle _generateTextStyle() {
    return TextStyle(fontSize: 12);
  }

  bool _isPhoneValid(String phone) {
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    return exp.hasMatch(phone);
  }
}
