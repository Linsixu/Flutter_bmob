import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_registered.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmob/model/MyBmobUser.dart';
import 'package:flutter_bmob/utils/share_preferences.dart';
import 'package:flutter_bmob/utils/toast_helper.dart';

class LoginUserModel with ChangeNotifier {
  MyBmobUser newCurrentUser;

  loginSuccess(MyBmobUser newUser) {
    newCurrentUser = newUser;
  }

  unLoginSuccess() {
    newCurrentUser = null;
  }

  Future<bool> login(
      BuildContext context, String userName, String password) async {
    String errorMsg;
    MyBmobUser currentUser = MyBmobUser();
    currentUser.username = userName;
    currentUser.password = password;
    await currentUser.login().then((MyBmobUser bmobUser) {
      showToast("登录成功");
      newCurrentUser = bmobUser;
      LocalDataHelper.saveUserMessage(newCurrentUser);
      notifyListeners();
    }).catchError((e) {
      currentUser = null;
      errorMsg = _getErrorMessage(BmobError.convert(e).code);
      showToast(errorMsg);
    }).whenComplete(() {
      Navigator.pop(context);
    });
    return !(errorMsg != null);
  }

  registerParentModel(
      String username, String psd, String childName, String phone) {
    MyBmobUser registerUser = MyBmobUser();
    registerUser.username = username;
    registerUser.password = psd;
    registerUser.self_name = childName;
    registerUser.childname = childName;
    registerUser.phone = phone;
    registerUser.isTeacher = false;
    registerUser.register().then((BmobRegistered data) {
      showToast("注册成功");
      newCurrentUser = registerUser;
      LocalDataHelper.saveUserMessage(newCurrentUser);
      notifyListeners();
    }).catchError((e) {
      showToast(_getErrorMessage(BmobError.convert(e).code));
    });
  }

  String _getErrorMessage(int code) {
    String error = "未知错误";
    switch (code) {
      case 101:
        error = '用户名或密码出错';
        break;
      case 202:
        error = '该用户已存在';
        break;
      default:
        break;
    }
    return error;
  }

  getLocalUser() {
    LocalDataHelper.getCurrentUser().then((user) {
      if (user != null) {
        newCurrentUser = user;
        notifyListeners();
      }
    });
  }
}
