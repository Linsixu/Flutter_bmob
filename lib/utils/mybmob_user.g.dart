import 'package:flutter_bmob/model/MyBmobUser.dart';

MyBmobUser MyBmobUserFromJson(Map<String, dynamic> json) {
  return MyBmobUser()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..username = json['username'] as String
    ..password = json['password'] as String
    ..email = json['email'] as String
    ..emailVerified = json['emailVerified'] as bool
    ..mobilePhoneNumber = json['mobilePhoneNumber'] as String
    ..mobilePhoneNumberVerified = json['mobilePhoneNumberVerified'] as bool
    ..sessionToken = json['sessionToken'] as String
    ..phone = json['phone'] as String
    ..isTeacher = json['isteacher'] as bool
    ..childname = json['childname'] as String
    ..self_name = json['self_name'] as String;
}

Map<String, dynamic> MyBmobUserToJson(MyBmobUser instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'mobilePhoneNumber': instance.mobilePhoneNumber,
      'mobilePhoneNumberVerified': instance.mobilePhoneNumberVerified,
      'sessionToken': instance.sessionToken,
      'phone': instance.phone,
      'isteacher': instance.isTeacher,
      'childname': instance.childname,
      'self_name': instance.self_name
    };
