import 'package:flutter/material.dart';
import 'package:flutter_expired_app/constants.dart';
import 'package:flutter_expired_app/screens/home/home_screen.dart';
import 'package:flutter_expired_app/screens/login/widgets/body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD470),
        elevation: 0,
      ),
    );
  }
}
