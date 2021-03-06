import 'package:flutter/material.dart';
import 'package:flutter_bmob/login/RegisterPage.dart';
import 'package:flutter_bmob/model/LoginUserModel.dart';
import 'package:flutter_bmob/view/LoadingViewV2.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _FormTestState();
  }
}

class _FormTestState extends State<LoginPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<LoginUserModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("登录"),
        ),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
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
                    // 登录按钮
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.all(15.0),
                              child: Text("登录"),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: () {
                                // 通过_formKey.currentState 获取FormState后，
                                // 调用validate()方法校验用户名密码是否合法，校验
                                // 通过后再提交数据。
                                if ((_formKey.currentState as FormState)
                                    .validate()) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return new LoadingDialog(
                                          //调用对话框
                                          text: '正在登录...',
                                        );
                                      });
                                  //验证通过提交数据
                                  _currentUser.login(context, _unameController.text,
                                          _pwdController.text)
                                      .then((success) {
                                    if (success) {
                                      Navigator.pop(context);
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.all(15.0),
                              child: Text("注册"),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: () {
                                isloading = false;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage(),
                                        maintainState: false));
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  TextStyle _generateTextStyle() {
    return TextStyle(fontSize: 12);
  }
}
