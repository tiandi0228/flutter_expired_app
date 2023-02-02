import 'package:flutter/material.dart';
import 'package:flutter_expired_app/constants.dart';
import 'package:flutter_expired_app/screens/create/widgets/form_page.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: mBackgroundColor,
      ),
      child: const FormPage(),
    );
  }
}
