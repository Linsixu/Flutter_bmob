import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_registered.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:flutter_bmob/model/MyBmobUser.dart';
import 'package:flutter/material.dart';
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

  login(BuildContext context, String userName, String password) {
    MyBmobUser currentUser = MyBmobUser();
    currentUser.username = userName;
    currentUser.password = password;
    currentUser.login().then((MyBmobUser bmobUser) {
      newCurrentUser = bmobUser;
      notifyListeners();
      Future result = LocalDataHelper().saveUserMessage(newCurrentUser);
      result.then((Null){
        Navigator.pop(context);
      });
//      Navigator.pop(context);
    }).catchError((e) {
      currentUser = null;
      showToast(_getErrorMessage(BmobError
          .convert(e)
          .code));
    });
  }

  registerParentModel(String username, String psd, String childName,
      String phone) {
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
      notifyListeners();
    }).catchError((e) {
      showToast(_getErrorMessage(BmobError
          .convert(e)
          .code));
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
}
