import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:flutter_bmob/model/MyBmobUser.dart';
import 'package:flutter/material.dart';

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
      showSuccess(
          context, newCurrentUser.phone + "\n" + newCurrentUser.childname);
      notifyListeners();
      Navigator.pop(context);
    }).catchError((e) {
      currentUser = null;
      showError(context, BmobError.convert(e).code.toString());
    });
  }

  String _showErrorDialog(int code) {
    String error = "未知错误";
    switch (code) {
      case 101:
        error = '用户名或密码出错';
        break;
      default:
        break;
    }
    return error;
  }
}
