import 'package:flutter_bmob/model/MyBmobUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String ID_KEY = "objectId";
final String NAME_KEY = "username";
final String PSD_KEY = "password";
final String VERTICAL_KEY = "vertical";
final String PHONE_KEY = "phone";
final String CHILD_NAME_KEY = "childname";

class LocalDataHelper {
  static SharedPreferences sharedPreferences;

  putValue<T>(String key, T t) {
    if (t is int) {
      _putIntValue(key, t);
    } else if (t is String) {
      _putStringValue(key, t);
    } else if (t is bool) {
      _putBooleanValue(key, t);
    }
  }

  _putIntValue(String key, int value) async {
    getShareInstance().then((share) {
      share.setInt(key, value);
    });
  }

  _putStringValue(String key, String value) async {
    getShareInstance().then((share) {
      share.setString(key, value);
    });
  }

  _putBooleanValue(String key, bool value) async {
    getShareInstance().then((share) {
      share.setBool(key, value);
    });
  }

  getValue<T>(String key, T t) {
    if (t is int) {
      _putIntValue(key, t);
    } else if (t is String) {
      _putStringValue(key, t);
    } else if (t is bool) {
      _putBooleanValue(key, t);
    }
  }

  _getIntValue(String key) async {
    getShareInstance().then((share) {
      share.getInt(key);
    });
  }

  _getStringValue(String key) async {
    getShareInstance().then((share) {
      share.get(key);
    });
  }

  _getBooleanValue(String key) async {
    getShareInstance().then((share) {
      share.getBool(key);
    });
  }

  static Future<SharedPreferences> getShareInstance() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    } else {
      return sharedPreferences;
    }
  }

  static Future<bool> saveUserMessage(MyBmobUser user) async {
    getShareInstance().then((f) {
      f.setString(ID_KEY, user.objectId);
      f.setString(NAME_KEY, user.username);
      f.setString(PSD_KEY, user.password);
      f.setBool(VERTICAL_KEY, user.isTeacher);
      f.setString(PHONE_KEY, user.phone);
      f.setString(CHILD_NAME_KEY, user.childname);
      return true;
    });
  }

  static clearCurrentUser() {
    getShareInstance().then((f) {
      f.remove(ID_KEY);
      f.remove(NAME_KEY);
      f.remove(PSD_KEY);
      f.remove(VERTICAL_KEY);
      f.remove(PHONE_KEY);
      f.remove(CHILD_NAME_KEY);
    });
  }

  static Future<MyBmobUser> getCurrentUser() async {
    MyBmobUser myBmobUser;
    await getShareInstance().then((f) {
      String objectId = f.getString(ID_KEY);
      if (objectId.isNotEmpty) {
        myBmobUser = MyBmobUser();
        myBmobUser.username = f.getString(NAME_KEY);
        myBmobUser.password = f.getString(PSD_KEY);
        myBmobUser.isTeacher = f.getBool(VERTICAL_KEY);
        myBmobUser.self_name = myBmobUser.childname = f.getString(CHILD_NAME_KEY);
        myBmobUser.phone = f.getString(PHONE_KEY);
      }
    });
    return myBmobUser;
  }
}
