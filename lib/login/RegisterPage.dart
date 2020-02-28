import 'package:flutter/material.dart';

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
  TextEditingController _parentNameController = new TextEditingController();
  TextEditingController _childNameController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Form(
              key: _formKey, //设置globalKey，用于后面获取FormState
              autovalidate: true, //开启自动校验
              child: Column(
                children: <Widget>[
                  Image.asset(
                      'assets/images/music_logo.png',
                      width: 100,
                      height: 100,
                      alignment: Alignment.center
                  ),
                  TextFormField(
                      autofocus: true,
                      controller: _unameController,
                      decoration: InputDecoration(
                          labelText: "用户名",
                          hintText: "手机或者邮箱",
                          icon: Icon(Icons.person, size: 30)),
                      // 校验用户名
                      validator: (v) {
                        return v.trim().length > 0 ? null : "用户名不能为空";
                      }),
                  TextFormField(
                      controller: _pwdController,
                      decoration: InputDecoration(
                          labelText: "密码",
                          hintText: "您的登录密码",
                          icon: Icon(Icons.lock, size: 30)),
                      obscureText: true,
                      //校验密码
                      validator: (v) {
                        return v.trim().length > 5 ? null : "密码不能少于6位";
                      }),
                  TextFormField(
                      controller: _parentNameController,
                      decoration: InputDecoration(
                          labelText: "姓名",
                          hintText: "您的姓名",
                          icon: Icon(Icons.contact_mail, size: 30)),
                      obscureText: false,
                      //校验密码
                      validator: (v) {
                        return v.trim().length > 0 ? null : "您的名字不能为空";
                      }),
                  TextFormField(
                      controller: _childNameController,
                      decoration: InputDecoration(
                          labelText: "姓名",
                          hintText: "您子女的姓名",
                          icon: Icon(Icons.child_care, size: 30)),
                      obscureText: false),
                  // 登录按钮
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
}
