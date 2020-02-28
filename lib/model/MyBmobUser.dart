import 'dart:convert';

import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/bmob_dio.dart';
import 'package:data_plugin/bmob/response/bmob_registered.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:flutter_bmob/utils/mybmob_user.g.dart';

class MyBmobUser extends BmobUser {
  String childname;
  bool isTeacher;
  String phone;
  String self_name;

  MyBmobUser();

  String getVerticalMsg() {
    if (isTeacher) {
      return '教师';
    } else {
      return '学生';
    }
  }

  //此处与类名一致，由指令自动生成代码
  factory MyBmobUser.fromJson(Map<String, dynamic> json) =>
      MyBmobUserFromJson(json);

//此处与类名一致，由指令自动生成代码
  Map<String, dynamic> toJson() => MyBmobUserToJson(this);

  ///账号密码登录
  Future<MyBmobUser> login() async {
    Map<String, dynamic> map = toJson();
    Map<String, dynamic> data = new Map();
    //去除由服务器生成的字段值
    map.remove("objectId");
    map.remove("createdAt");
    map.remove("updatedAt");
    map.remove("sessionToken");
    //去除空值
    map.forEach((key, value) {
      if (value != null) {
        data[key] = value;
      }
    });
    //Map转String
    //发送请求
    Map result = await BmobDio.getInstance()
        .get(Bmob.BMOB_API_LOGIN + getUrlParams(data));
    MyBmobUser bmobUser = MyBmobUser.fromJson(result);
    BmobDio.getInstance().setSessionToken(bmobUser.sessionToken);
    return bmobUser;
  }


  ///用户账号密码注册
  Future<BmobRegistered> register() async {
    Map<String, dynamic> map = toJson();
    Map<String, dynamic> data = new Map();
    //去除由服务器生成的字段值
    map.remove("objectId");
    map.remove("createdAt");
    map.remove("updatedAt");
    map.remove("sessionToken");
    //去除空值
    map.forEach((key, value) {
      if (value != null) {
        data[key] = value;
      }
    });
    //Map转String
    String params = json.encode(data);
    //发送请求
    Map responseData =
    await BmobDio.getInstance().post(Bmob.BMOB_API_USERS, data: params);
    BmobRegistered bmobRegistered = BmobRegistered.fromJson(responseData);
    BmobDio.getInstance().setSessionToken(bmobRegistered.sessionToken);
    return bmobRegistered;
  }

  @override
  String toString() {
    return 'MyBmobUser{childname: $childname, isTeacher: $isTeacher, phone: $phone, self_name: $self_name}';
  }


}
