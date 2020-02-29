import 'package:flutter/material.dart';
import 'package:flutter_bmob/login/LoginPage.dart';
import 'package:flutter_bmob/model/LoginUserModel.dart';
import 'package:flutter_bmob/model/MyBmobUser.dart';
import 'package:flutter_bmob/utils/share_preferences.dart';
import 'package:provider/provider.dart';

final List<String> text = <String>["我的信息", "我的课程", "发布课程", "我的设置", "退出登录"];
final List<Icon> icons = <Icon>[
  Icon(Icons.person),
  Icon(Icons.assignment),
  Icon(Icons.border_color),
  Icon(Icons.settings),
  Icon(Icons.exit_to_app)
];

class MySetting extends StatelessWidget {
  const MySetting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<LoginUserModel>(context);
    _currentUser.getLocalUser();
    // TODO: implement build
    return Scaffold(
        body: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return new GestureDetector(
                  onTap: () {
                    if (_currentUser.newCurrentUser != null) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage(),
                            maintainState: false));
                  },
                  child: Container(
                    height: 80,
                    child: Row(
                      children: <Widget>[
                        ClipOval(
                          child: Image.asset('assets/images/user_image.png',
                              width: 55, height: 55),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                child: Text(
                                  '${_currentUser.newCurrentUser != null ? "孩子名字:" + _currentUser.newCurrentUser.self_name : "请先点击登录"}',
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12),
                                ),
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              ),
                              Padding(
                                child: Text(
                                  '${_currentUser.newCurrentUser != null ? '手机号码:' + _currentUser.newCurrentUser.phone : "暂无信息"}',
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 12),
                                ),
                                padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                              ),
                              Padding(
                                child: Text(
                                  '${_currentUser.newCurrentUser != null ? '个人信息:' + _currentUser.newCurrentUser.getVerticalMsg() : ""}',
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 12),
                                ),
                                padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                              )
                            ]),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  height: 50,
                  child: Row(children: <Widget>[
                    icons[index - 1],
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(text[index - 1])),
                    )
                  ]),
                );
              }
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: (icons.length + 1)));
  }
}
