/*
 * @Author: error: git config user.name && git config user.email & please set dead value or install git
 * @Date: 2023-01-08 10:17:06
 * @LastEditors: error: git config user.name && git config user.email & please set dead value or install git
 * @LastEditTime: 2023-01-09 10:31:39
 * @FilePath: \flutter_expired_app\lib\screens\login\widgets\login_header.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_expired_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginHeader extends StatefulWidget {
  const LoginHeader({super.key});

  @override
  State<LoginHeader> createState() => _LoginHeaderState();
}

class _LoginHeaderState extends State<LoginHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 220.w,
      child: Column(
        children: [
          Container(
            width: 100.w,
            height: 100.w,
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF5CB6C),
              borderRadius: BorderRadius.circular(60),
            ),
            child: SvgPicture.asset(
              'assets/icons/phone.svg',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "欢迎登录",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.w),
          const Text(
            "请输入手机号码和密码进行登录",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: mTitleColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
