import 'package:flutter/material.dart';
import 'package:flutter_expired_app/constants.dart';
import 'package:flutter_expired_app/model/user.dart';
import 'package:flutter_expired_app/routes.dart';
import 'package:flutter_expired_app/screens/home/home_screen.dart';
import 'package:flutter_expired_app/service/services.dart';
import 'package:flutter_expired_app/size_config.dart';
import 'package:flutter_expired_app/store/local_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ftoast/ftoast.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool pwdToggle = false;
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight - 220.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.w),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 60.w,
          ),
          _buildPhoneInput(),
          SizedBox(
            height: 30.w,
          ),
          _buildPasswordInput(),
          SizedBox(
            height: 30.w,
          ),
          _buildSubmit(context),
        ],
      ),
    );
  }

  // 手机号码
  Widget _buildPhoneInput() {
    return Container(
      width: double.infinity,
      height: 50.w,
      margin: EdgeInsets.only(
        left: 40.w,
        right: 40.w,
      ),
      child: TextFormField(
        controller: _unameController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: mBorderColor,
              width: 0.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: mBackgroundColor,
              width: 0.5,
            ),
          ),
          hintText: "请输入手机号码",
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black26,
          ),
        ),
        cursorColor: Colors.black,
        // 校验用户名
        validator: (v) {
          String t = v ?? '';
          return t.trim().isNotEmpty ? null : "手机号码不能为空";
        },
      ),
    );
  }

  // 密码
  Widget _buildPasswordInput() {
    return Container(
      width: double.infinity,
      height: 50.w,
      margin: EdgeInsets.only(
        left: 40.w,
        right: 40.w,
      ),
      child: TextFormField(
        controller: _pwdController,
        keyboardType: TextInputType.visiblePassword,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: mBorderColor,
              width: 0.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: mBackgroundColor,
              width: 0.5,
            ),
          ),
          hintText: "请输入密码",
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black26,
          ),
        ),
        obscureText: !pwdToggle,
        cursorColor: Colors.black,
        //校验密码
        validator: (v) {
          String t = v ?? '';
          return t.trim().length > 5 ? null : "密码不能少于6位";
        },
      ),
    );
  }

  // 登录按钮
  Widget _buildSubmit(BuildContext context) {
    // 登录
    void onLogin() async {
      if (_unameController.value.text.length != 11) {
        FToast.toast(
          context,
          duration: 800,
          msg: '请输入手机号码',
          msgStyle: const TextStyle(
            color: Colors.white,
          ),
        );
        return;
      }

      if (_pwdController.value.text == '') {
        FToast.toast(
          context,
          duration: 800,
          msg: '请输入密码',
          msgStyle: const TextStyle(
            color: Colors.white,
          ),
        );
        return;
      }

      UserModel user = await LoginAPI.getCreateData(
        phone: _unameController.value.text,
        password: _pwdController.value.text,
      );

      if (user.accessToken != "") {
        // ignore: use_build_context_synchronously
        FToast.toast(
          context,
          duration: 800,
          msg: '登录成功！',
          msgStyle: const TextStyle(
            color: Colors.white,
          ),
        );
        LocalStorage.set(Constants.accessTokenKey, user.accessToken);
        // ignore: use_build_context_synchronously
        AppRouter.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName);
      }
    }

    return Container(
      width: double.infinity,
      height: 50.w,
      margin: EdgeInsets.only(
        left: 40.w,
        right: 40.w,
      ),
      child: TextButton(
        onPressed: onLogin,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(100, 40)),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(const Color(0xFFFFD470)),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: const Text(
          '登录',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
