import 'package:flutter_expired_app/model/user.dart';
import 'package:flutter_expired_app/utils/request.dart';

// 登录
class LoginAPI {
  static Future<dynamic> getCreateData({
    // 手机号码
    required String phone,
    required String password,
  }) async {
    var response = await RequestUtil().post('login', params: {
      "phone": phone,
      "password": password,
    });

    return UserModel.fromJson(response);
  }
}
