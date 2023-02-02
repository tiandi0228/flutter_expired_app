import 'package:flutter/material.dart';
import 'package:flutter_expired_app/screens/login/widgets/login_form.dart';
import 'package:flutter_expired_app/screens/login/widgets/login_header.dart';
import 'package:flutter_expired_app/size_config.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          color: Color(0xFFFFD470),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              LoginHeader(),
              SizedBox(height: 40),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
