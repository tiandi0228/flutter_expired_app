import 'dart:io';

import 'package:flutter/material.dart';

const mModuleColor = Color(0xFFF5F6F9); // 模块颜色
const mBorderColor = Color(0xFFA3A3A3); // 边框颜色
const mTitleColor = Color(0xFF757575); // 标题颜色
const mBackgroundColor = Color(0xFFD8D8D8); // 全局背景色
const double mDefaultPadding = 20.0;

// 一些常量
class Constants {
  static const accessTokenKey = "access-token";

  // 支付方式常量 Speedly
  static const payMethodSpeedly = "Speedly";

  // 安卓
  static bool isAndroid = Platform.isAndroid;

  // 苹果
  static bool isIos = Platform.isIOS;
}
