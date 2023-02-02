import 'package:flutter/material.dart';
import 'package:flutter_expired_app/app.dart';
import 'package:flutter_expired_app/store/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化本地存储实例
  LocalStorage.initSP();

  runApp(const MyApp());
}
